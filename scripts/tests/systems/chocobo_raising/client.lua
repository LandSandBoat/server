-----------------------------------
-- Drives a VCS trainer like the client does and decodes the replies.
-----------------------------------

---@class RaisingEventStart
---@field eventId integer
---@field params integer[]
---@field strings string[]?

---@class RaisingClient
---@field player CClientEntityPair
---@field trainer string|integer
---@field csid integer?
local raisingClient = {}

local trainers =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 'Hantileon',
    [xi.zone.BASTOK_MINES]       = 'Zopago',
    [xi.zone.WINDURST_WOODS]     = 'Pulonono',
}

function raisingClient.readU32(data, offset)
    return data[offset] + data[offset + 1] * 0x100 + data[offset + 2] * 0x10000 + data[offset + 3] * 0x1000000
end

local function readParams(data, offset)
    local params = {}
    for i = 0, 7 do
        params[i] = raisingClient.readU32(data, offset + i * 4)
    end

    return params
end

---@param player CClientEntityPair
---@return RaisingClient
function raisingClient.new(player)
    local client = {}
    client.player  = player
    client.trainer = trainers[player:getZoneID()]
    client.csid    = xi.chocoboRaising.csidTable[player:getZoneID()][2]

    return client
end

---@param player CClientEntityPair
---@param npcName string
---@param csid integer?
---@return RaisingClient
function raisingClient.forNPC(player, npcName, csid)
    local client = {}
    client.player  = player
    client.trainer = npcName
    client.csid    = csid

    return client
end

-- Each stable's debug chocobo; Windurst's has no name, so all are keyed by entity id.
local debugChocobos =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 17719346,
    [xi.zone.BASTOK_MINES]       = 17735727,
    [xi.zone.WINDURST_WOODS]     = 17764444,
}

---@param player CClientEntityPair
---@return RaisingClient
function raisingClient.newDebug(player)
    local client = {}
    client.player  = player
    client.trainer = debugChocobos[player:getZoneID()]
    client.csid    = xi.chocoboRaising.debugCSID(player)

    return client
end

-- Every event update the server sent since the last clear, as 0-indexed param arrays.
---@param client RaisingClient
function raisingClient.replies(client)
    local replies = {}
    for _, packet in pairs(client.player.packets:getIncoming()) do
        if packet.type == 0x05C then
            table.insert(replies, readParams(packet.data, 0x04))
        end
    end

    return replies
end

local function readString(data, offset)
    local chars = {}
    for i = 0, 15 do
        local byte = data[offset + i]
        if not byte or byte == 0 then
            break
        end

        table.insert(chars, string.char(byte))
    end

    return table.concat(chars)
end

-- The four strings of the last name packet (0x05D) since the last clear.
---@param client RaisingClient
function raisingClient.strings(client)
    local strings
    for _, packet in pairs(client.player.packets:getIncoming()) do
        if packet.type == 0x05D then
            strings = {}
            for i = 0, 3 do
                strings[i] = readString(packet.data, 0x28 + i * 16)
            end
        end
    end

    return strings
end

---@param client RaisingClient
function raisingClient.eventStart(client)
    local start
    for _, packet in pairs(client.player.packets:getIncoming()) do
        if packet.type == 0x032 then
            start = { eventId = packet.data[0x0C] + packet.data[0x0D] * 0x100, params = {} }
        elseif packet.type == 0x033 then
            start = { eventId = packet.data[0x0C] + packet.data[0x0D] * 0x100, params = readParams(packet.data, 0x50), strings = {} }
            for i = 0, 3 do
                start.strings[i] = readString(packet.data, 0x10 + i * 16)
            end
        elseif packet.type == 0x034 then
            start = { eventId = packet.data[0x2C] + packet.data[0x2D] * 0x100, params = readParams(packet.data, 0x08) }
        end
    end

    return start
end

---@param client RaisingClient
---@return RaisingEventStart
function raisingClient.talk(client)
    client.player.packets:clear()
    client.player.entities:gotoAndTrigger(client.trainer)

    return assert(raisingClient.eventStart(client), string.format('Expected %s to start an event', client.trainer))
end

---@param client RaisingClient
---@param items table
---@return RaisingEventStart
function raisingClient.trade(client, items)
    client.player.packets:clear()
    client.player.actions:tradeNpc(client.trainer, items)

    return assert(raisingClient.eventStart(client), string.format('Expected %s to start an event on the trade', client.trainer))
end

-- Fails unless the server answers exactly once.
---@param client RaisingClient
---@param option integer
function raisingClient.send(client, option)
    client.player.packets:clear()
    client.player.events:update(nil, option)

    local replies = raisingClient.replies(client)
    assert(#replies == 1, string.format('Option %d: expected exactly one reply, got %d', option, #replies))

    return replies[1]
end

---@param client RaisingClient
---@param option integer?
function raisingClient.finish(client, option)
    client.player.packets:clear()
    client.player.events:finish(nil, option or 0)
end

-- Plays a whole visit in the client's option order and returns what it showed.
---@param client RaisingClient
function raisingClient.visit(client)
    local start = raisingClient.talk(client)
    assert(start and start.eventId == client.csid, string.format('Expected event %d, got %s', client.csid, start and start.eventId))

    local location = xi.chocoboRaising.raisingLocation[client.player:getZoneID()]
    local visit    =
    {
        start           = start,
        records         = {},
        cutscenes       = {},
        cutsceneReplies = {},
    }

    raisingClient.send(client, 244)

    if
        start.params[1] ~= 0 and
        raisingClient.send(client, 208)[0] == 0xFFFFFFFF
    then
        -- More records follow while bit 31 of the header is set.
        for _ = 1, 130 do
            local record = raisingClient.send(client, 248)
            local header = record[1]

            table.insert(visit.records, { startDay = bit.band(header, 0x3FF), endDay = bit.band(bit.rshift(header, 20), 0x3FF), conditions = record[6] })

            for _ = 1, record[2] do
                local reply = raisingClient.send(client, 246)
                table.insert(visit.cutscenes, reply[1] - location * 256)
                table.insert(visit.cutsceneReplies, reply)
            end

            -- p7 set: the record held the retirement and the event ends after it.
            if record[7] ~= 0 then
                visit.retired = true
                raisingClient.finish(client, 0)

                return visit
            end

            if bit.band(header, 0x80000000) == 0 then
                break
            end
        end
    end

    local preMenu = raisingClient.send(client, 214)
    if preMenu[1] ~= 0 then
        visit.preMenuCutscene = preMenu[1] - location * 256
    end

    raisingClient.send(client, 215)
    raisingClient.finish(client, 0)

    return visit
end

-- Hands in a new Faintly Warm egg at the zone's trainer and returns the client for that trainer.
---@param player CClientEntityPair
---@return RaisingClient
function raisingClient.tradeEgg(player)
    local client = raisingClient.new(player)

    player:addItem(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
    raisingClient.trade(client, { xi.item.CHOCOBO_EGG_FAINTLY_WARM })
    raisingClient.send(client, 252)
    raisingClient.finish(client, 252)
    assert(player:getChocoboRaisingInfo(), 'Expected the egg trade to create a chocobo')

    return client
end

---@param player CClientEntityPair
---@param fields table
function raisingClient.setChocobo(player, fields)
    local info = player:getChocoboRaisingInfo()
    for key, value in pairs(fields) do
        info[key] = value
    end

    player:setChocoboRaisingInfo(info)
end

---@param player CClientEntityPair
---@param count integer
function raisingClient.leaveFreeSlots(player, count)
    player:changeContainerSize(xi.inventoryLocation.INVENTORY, count - player:getFreeSlotsCount())
    assert(player:getFreeSlotsCount() == count, string.format('Expected %d free slots, got %d', count, player:getFreeSlotsCount()))
end

-- Zones and finishes any zone-in cutscenes.
---@param player CClientEntityPair
---@param zoneId integer
function raisingClient.gotoZone(player, zoneId)
    player:gotoZone(zoneId)

    for _ = 1, 5 do
        if not player:isInEvent() then
            return
        end

        player.events:finish()
    end
end

-- Uses the Chocobo Whistle from the neck slot; towns forbid mounts, so call it outside one.
---@param player CClientEntityPair
function raisingClient.callChocobo(player)
    local item = assert(player:findItem(xi.item.CHOCOBO_WHISTLE), 'Expected a Chocobo Whistle')
    player:equipItem(xi.item.CHOCOBO_WHISTLE, nil, xi.slot.NECK)
    xi.test.world:skipTime(31)

    player.packets:clear()
    player.actions:useItem(player, item:getSlotID())
    xi.test.world:tickEntity(player)
    xi.test.world:skipTime(10)
    xi.test.world:tickEntity(player)
end

-- Text of every chat line since the last clear.
---@param player CClientEntityPair
---@return string
function raisingClient.chatText(player)
    local lines = {}
    for _, packet in pairs(player.packets:getIncoming()) do
        if packet.type == 0x017 then
            local chars = {}
            for i = 0, packet.size - 1 do
                local byte = packet.data[i]
                if byte and byte >= 0x20 and byte < 0x7F then
                    table.insert(chars, string.char(byte))
                end
            end

            table.insert(lines, table.concat(chars))
        end
    end

    return table.concat(lines, '\n')
end

-- A nil expectation skips that param.
---@param label string
---@param actual integer[]
---@param expected (integer|nil)[]
function raisingClient.expectReply(label, actual, expected)
    for i = 0, 7 do
        local want = expected[i + 1]
        if want then
            assert(actual[i] == want, string.format('%s: p%d is %d, expected %d', label, i, actual[i], want))
        end
    end
end

---@param reply integer[]
---@param label string?
function raisingClient.assertZeros(reply, label)
    for i = 0, 7 do
        assert(reply[i] == 0, string.format('%s: expected a zero reply, p%d is %d', label or 'Refusal', i, reply[i]))
    end
end

function raisingClient.replyFor(visit, cutscene)
    for index, played in ipairs(visit.cutscenes) do
        if played == cutscene then
            return visit.cutsceneReplies[index]
        end
    end

    return nil
end

function raisingClient.heard(visit, cutscene)
    for _, played in ipairs(visit.cutscenes) do
        if played == cutscene then
            return true
        end
    end

    return false
end

return raisingClient
