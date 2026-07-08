-----------------------------------
-- Linkshell Concierge
-----------------------------------
xi = xi or {}
xi.linkshellConcierge = xi.linkshellConcierge or {}

local settings =
{
    -- How many days must have elapsed before you can submit a linkshell.
    -- Note: Client event will still show 45
    ageReq = xi.settings.main.LINK_CONCIERGE_AGE_REQ or 45,
}

-- Data comes in over many packets, we must temporarily keep track of each session
local sessions = {} -- [playerId] = active-event scratch

local function now()
    return GetSystemTime() - 1009843200 -- Time since Jan 1st 2002
end

local function findInList(rows, predicate)
    for _, row in ipairs(rows) do
        if predicate(row) then
            return row
        end
    end

    return nil
end

local function findOwnSlot(rows, playerId)
    return findInList(rows, function(r)
        return r.ownerCharId == playerId
    end)
end

local function findByGroupId(rows, groupId)
    return findInList(rows, function(r)
        return r.linkshellid == groupId
    end)
end

local function daysSince(postedDate)
    if not postedDate or postedDate == 0 then
        return 0
    end

    return utils.clamp(math.floor((now() - postedDate) / 86400), 0, 99)
end

local function readLinkshellExdata(player, lsSlot)
    local item = player:getEquippedItem(lsSlot)
    if not item then
        return nil
    end

    local ex = item:getExData() --[[@as ExdataLinkshell]]
    if not ex or not ex.groupId or ex.groupId == 0 then
        return nil
    end

    if not ex.name or ex.name == '' then
        return nil
    end

    local c = ex.color or {}
    return
    {
        groupId  = ex.groupId,
        groupKey = ex.groupKey,
        flag     = ex.flag,
        name     = ex.name,
        color    = bit.bor(
            bit.band(c.r or 0, 0xF),
            bit.lshift(bit.band(c.g or 0, 0xF), 4),
            bit.lshift(bit.band(c.b or 0, 0xF), 8),
            bit.lshift(bit.band(c.a or 0, 0xF), 12)),
    }
end

local function isAgeEligible(player)
    return (GetSystemTime() - player:getTimeCreated()) >= settings.ageReq * 86400
end

local function getSessionFor(playerId)
    sessions[playerId] = sessions[playerId] or {}
    return sessions[playerId]
end

local function buildViewSlots(rows)
    local out = {}
    for _, r in ipairs(rows) do
        out[r.slotIndex] =
        {
            groupId         = r.linkshellid,
            groupKey        = r.groupKey,
            color           = r.color,
            flag            = r.flag,
            name            = r.name,
            lang            = r.lang,
            membersGoal     = r.membersGoal,
            activeTier      = r.activeTier,
            characteristics = r.characteristics,
        }
    end

    return out
end

local function opShowList(player, _, _, zoneId, _)
    local rows = LoadLinkshellConciergeSlots(zoneId)
    local own  = findOwnSlot(rows, player:getID())
    player:sendLinkshellConcierge(
        {
            yourSlot   = own and own.slotIndex,
            postedDays = own and daysSince(own.postedDate) or 0,
            slots      = buildViewSlots(rows),
        })
end

local function opStashLow(_, _, session, _, payload)
    session.selectedLow = payload
end

local function opStashHigh(_, _, session, _, payload)
    session.selectedHigh = payload
end

local function opSelectLs(player, _, session, zoneId, _)
    local key  = bit.bor(session.selectedLow or 0, bit.lshift(session.selectedHigh or 0, 16))
    local rows = LoadLinkshellConciergeSlots(zoneId)
    local ls   = findByGroupId(rows, key)
    if not ls then
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 1) -- Error path
        return
    end

    session.selectedGroupId = key
    -- params[0] encodes several info: ZZDD DDDD DDTT TTTTT
    -- Z: Timezone (2 bits)
    -- D: Days the linkshell is active (8 bits)
    -- T: Times the linkshell is active (8 bits)
    local params0 = bit.bor(
        bit.band(ls.tz or 0, 0x3),
        bit.lshift(bit.band(ls.days or 0, 0xFF), 2),
        bit.lshift(bit.band(ls.times or 0, 0xFFFFF), 10))
    player:updateEvent(
        params0,
        ls.postedDate or 0, -- How long ago the linkshell was added
        0, 0, 0,
        ls.lang or 0,       -- LS language (J/E/Other)
        0, 0)
end

local function opReceivePearl(player, npc, session, zoneId, _)
    if player:getCharVar('[concierge]pearlReceived') ~= 0 then
        local ID = zones[zoneId]
        player:messageText(npc, ID.text.LINK_CONCIERGE_ONE_PER_DAY)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 1)
        return
    end

    local key  = bit.bor(session.selectedLow or 0, bit.lshift(session.selectedHigh or 0, 16))
    local rows = LoadLinkshellConciergeSlots(zoneId)
    local ls   = findByGroupId(rows, key)
    local ok   = false
    if ls and ls.name ~= '' and session.selectedGroupId == key then
        ok = player:addLinkpearl(ls.name, false)
        if ok then
            session.lastGrantedGroupId = key
            player:setCharVar('[concierge]pearlReceived', 1, JstMidnight())
        end
    end

    session.selectedGroupId = nil
    session.selectedLow     = nil
    session.selectedHigh    = nil
    player:updateEvent(0, 0, 0, 0, 0, 0, 0, ok and 0 or 1)
end

local function opStashRegBasics(_, _, session, _, payload)
    session.regLang    = utils.clamp(bit.band(payload, 0x3), 1, 3)                 -- Japanese / English / Other
    session.regMembers = utils.clamp(bit.band(bit.rshift(payload, 2), 0xF), 1, 10) -- How many members we're looking for (1-10)
    session.regActive  = utils.clamp(bit.band(bit.rshift(payload, 6), 0x3), 0, 2)  -- How many members are active: 1-6, 7-18, 19+
end

local function opStashRegCharacteristics(_, _, session, _, payload)
    session.regCharacteristics = bit.band(payload, 0xFFFF)
end

local function opStashRegTzDays(_, _, session, _, payload)
    session.regTz   = bit.band(payload, 0x3) -- None, JST, PST, GMT
    session.regDays = bit.band(bit.rshift(payload, 2), 0xFF)
end

local function opStashRegTimes(_, _, session, _, payload)
    -- 4 × 5-bit fields: weekday start/stop, weekend start/stop. 0=NoTimeSet, 1..24=hour.
    local raw = bit.band(payload, 0xFFFFF)
    local out = 0
    for field = 0, 3 do
        local shift = field * 5
        local value = bit.band(bit.rshift(raw, shift), 0x1F)
        if value > 24 then
            value = 0
        end

        out = bit.bor(out, bit.lshift(value, shift))
    end

    session.regTimes = out
end

local opHandlers =
{
    [0]  = opShowList,                -- Show me recruiting linkshells
    [5]  = opStashLow,                -- Selected LS ID low 16 bits
    [6]  = opStashHigh,               -- Selected LS ID high 16 bits
    [7]  = opReceivePearl,            -- Receive linkpearl
    [11] = opStashRegBasics,          -- Registering: lang/members/active
    [12] = opStashRegCharacteristics, -- Registering: characteristics bitfield
    [13] = opStashRegTzDays,          -- Registering: timezone + days
    [14] = opStashRegTimes,           -- Registering: hours
    [15] = opSelectLs,                -- After selecting a linkshell in the window
}

xi.linkshellConcierge.onTrigger = function(player, npc)
    sessions[player:getID()] = nil

    local zoneId = npc:getZoneID()
    local rows   = LoadLinkshellConciergeSlots(zoneId)
    local ls1    = readLinkshellExdata(player, xi.slot.LINK1)
    local ls1Key = ls1 and ls1.groupId or 0
    local caps   = isAgeEligible(player) and 0x02 or 0x00

    player:startEvent(6100,
        0,
        player:getGil(), -- Player current gil
        0, 0, 0,
        caps,            -- Enabled capabilities
        #rows,           -- How many LS are currently stored
        ls1Key)          -- Player LS1 ID
end

xi.linkshellConcierge.onEventUpdate = function(player, csid, option, npc)
    if csid ~= 6100 then
        return
    end

    -- This event uses multiple opcodes packed together with the user-provided values in option.
    local op      = bit.band(option, 0xFF)
    local payload = bit.rshift(option, 8)
    local handler = opHandlers[op]
    if handler then
        handler(player, npc, getSessionFor(player:getID()), npc:getZoneID(), payload)
    end
end

local function commitRegister(player, npc, session, zoneId, ID)
    if not isAgeEligible(player) then
        return
    end

    local ls1 = readLinkshellExdata(player, xi.slot.LINK1)
    if not ls1 then
        return
    end

    local rows = LoadLinkshellConciergeSlots(zoneId)

    -- Another member of the same LS already holds a slot.
    for _, r in ipairs(rows) do
        if r.linkshellid == ls1.groupId and r.ownerCharId ~= player:getID() then
            player:messageText(npc, ID.text.LINK_CONCIERGE_LS_TAKEN)
            return
        end
    end

    -- Replace own existing slot if re-registering.
    local existing = findOwnSlot(rows, player:getID())
    if existing then
        DeleteLinkshellConciergeSlot(zoneId, existing.slotIndex)
    end

    -- 16 slots max; FIFO-evict oldest when full.
    local occupied = {}
    local oldest
    for _, r in ipairs(rows) do
        if r.ownerCharId ~= player:getID() then
            occupied[r.slotIndex] = r
            if not oldest or r.postedDate < oldest.postedDate then
                oldest = r
            end
        end
    end

    local idx
    for i = 0, 15 do
        if not occupied[i] then
            idx = i
            break
        end
    end

    if not idx then
        idx = oldest and oldest.slotIndex
    end

    if idx and player:getGil() >= 500 then
        player:delGil(500)
        SetLinkshellConciergeSlot(zoneId, idx,
            {
                linkshellid     = ls1.groupId,
                ownerCharId     = player:getID(),
                groupKey        = ls1.groupKey,
                flag            = ls1.flag,
                lang            = session.regLang or 0,
                membersGoal     = session.regMembers or 0,
                activeTier      = session.regActive or 0,
                characteristics = session.regCharacteristics or 0,
                tz              = session.regTz or 0,
                days            = session.regDays or 0,
                times           = session.regTimes or 0,
                postedDate      = now(),
            })
        player:messageText(npc, ID.text.LINK_CONCIERGE_REGISTERED)
        player:messageText(npc, ID.text.LINK_CONCIERGE_REGISTERED_2)
    end
end

local function commitDelist(player, npc, zoneId, ID)
    local rows = LoadLinkshellConciergeSlots(zoneId)
    local own  = findOwnSlot(rows, player:getID())
    if own then
        DeleteLinkshellConciergeSlot(zoneId, own.slotIndex)
    end

    player:messageText(npc, ID.text.LINK_CONCIERGE_GOODBYE)
end

xi.linkshellConcierge.onEventFinish = function(player, csid, option, npc)
    if csid ~= 6100 then
        return
    end

    local commit  = bit.band(option, 0x3)
    local zoneId  = npc:getZoneID()
    local session = getSessionFor(player:getID())
    local ID      = zones[zoneId]

    if commit == 1 then
        commitRegister(player, npc, session, zoneId, ID)
    elseif commit == 2 then
        -- Pearl pickup committed: decrement remaining slots; auto-removes when it hits 0.
        if session.lastGrantedGroupId then
            DecrementLinkshellConciergeMembersGoal(zoneId, session.lastGrantedGroupId)
        end
    elseif commit == 3 then
        commitDelist(player, npc, zoneId, ID)
    end

    sessions[player:getID()] = nil
end

return xi.linkshellConcierge
