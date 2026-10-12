local configPacket     = 0x0B4
local charStatusPacket = 0x037

---@param player CClientEntityPair
---@param packetType integer
---@return IncomingPacket[]
local function packetsOfType(player, packetType)
    local found = {}
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == packetType then
            table.insert(found, packet)
        end
    end

    return found
end

-- True when the last packet of that type has the bit set.
---@param player CClientEntityPair
---@param packetType integer
---@param offset integer
---@param mask integer
---@return boolean
local function lastHasBit(player, packetType, offset, mask)
    local packets = packetsOfType(player, packetType)
    assert(#packets > 0, string.format('no 0x%03X packet received', packetType))

    return bit.band(packets[#packets].data[offset], mask) ~= 0
end

---@param player CClientEntityPair
---@return boolean
local function isSeeking(player)
    return lastHasBit(player, configPacket, 0x04, 0x01)
end

---@param player CClientEntityPair
---@return boolean
local function isAccepting(player)
    return lastHasBit(player, configPacket, 0x07, 0x20)
end

describe('Party request', function()
    ---@type CClientEntityPair
    local requester
    ---@type CClientEntityPair
    local recipient

    before_each(function()
        requester = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        recipient = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
        recipient:setPos(requester:getXPos(), requester:getYPos(), requester:getZPos())

        requester.packets:clear()
        recipient.packets:clear()
    end)

    describe('accepting requests flag', function()
        it('shows in the config and status packets', function()
            recipient.actions:setAcceptingRequests(true)

            assert(isAccepting(recipient), 'config packet does not show accepting')
            assert(not isSeeking(recipient), 'seeking flag was set')
            assert(lastHasBit(recipient, charStatusPacket, 0x38, 0x01), 'status packet does not show accepting')

            recipient.packets:clear()
            recipient.actions:setAcceptingRequests(false)

            assert(not isAccepting(recipient), 'config packet still shows accepting')
            assert(not lastHasBit(recipient, charStatusPacket, 0x38, 0x01), 'status packet still shows accepting')
        end)

        it('is cleared by seeking a party', function()
            recipient.actions:setAcceptingRequests(true)
            recipient.actions:setSeekingParty(true)

            assert(isSeeking(recipient), 'seeking flag was not set')
            assert(not isAccepting(recipient), 'accepting flag was not cleared')
        end)

        it('clears the seeking party flag', function()
            recipient.actions:setSeekingParty(true)
            recipient.actions:setAcceptingRequests(true)

            assert(isAccepting(recipient), 'accepting flag was not set')
            assert(not isSeeking(recipient), 'seeking flag was not cleared')
        end)

        it('stays up after forming a party', function()
            recipient.actions:setAcceptingRequests(true)
            recipient.actions:inviteToParty(requester)
            requester.actions:acceptPartyInvite()
            assert(recipient:getPartySize() == 2, 'party was not formed')

            -- any config packet gets the current flags back
            recipient.packets:clear()
            recipient.actions:setSeekingParty(false)

            assert(isAccepting(recipient), 'accepting flag was cleared by forming a party')
        end)
    end)
end)
