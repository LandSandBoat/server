-----------------------------------
-- Al Zahbi siege cutscenes
-----------------------------------
local packetReader = require('scripts.tests.helpers.packet_reader')

local fatedStrife        = 142
local bustleOfTheCapital = 178

local musicSlots =
{
    xi.musicSlot.ZONE_DAY,
    xi.musicSlot.ZONE_NIGHT,
    xi.musicSlot.COMBAT_SOLO,
    xi.musicSlot.COMBAT_PARTY,
}

-- The params of the last event update since the last clear.
local function lastUpdate(player)
    local reply
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == 0x05C then
            reply = packetReader.readParams(packet.data, 0x04)
        end
    end

    assert(reply, 'No event update was sent')

    return reply
end

-- Track set on each music slot since the last clear.
local function musicChanges(player)
    local tracks = {}
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == 0x05F then
            tracks[packetReader.readU16(packet.data, 0x04)] = packetReader.readU16(packet.data, 0x06)
        end
    end

    return tracks
end

describe('Besieged siege events', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        SetVolatileServerVariable('[Besieged]GeneralsCaptured', 0)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.AL_ZAHBI })
        player.packets:clear()
    end)

    it('plays the opening for each army with the player as the actor', function()
        local openings =
        {
            [xi.besieged.stronghold.MAMOOK  ] =  8,
            [xi.besieged.stronghold.HALVUNG ] = 11,
            [xi.besieged.stronghold.ARRAPAGO] =  5,
        }

        for stronghold, csid in pairs(openings) do
            player.packets:clear()
            xi.besieged.startSiegeEvent(player, { stronghold = stronghold, outcome = xi.besieged.outcome.START })

            assert(packetReader.lastEventStart(player).actor == player:getID(), 'The player is not the actor')
            player.events:expect({ eventId = csid, finishOption = 5 })
        end
    end)

    it('sends the leader flag in param 6 of the opening', function()
        xi.besieged.startSiegeEvent(player, { stronghold = xi.besieged.stronghold.MAMOOK, outcome = xi.besieged.outcome.START, leader = true })

        assert(packetReader.lastEventStart(player).params[6] == 1, 'Leader flag not set')
        player.events:expect({ eventId = 8, finishOption = 5 })
    end)

    it('answers updates with the generals standing and their seal count', function()
        local cases =
        {
            { standing = 31, seals = 5 },
            { standing = 14, seals = 3 },
            { standing =  0, seals = 0 },
        }

        for _, case in ipairs(cases) do
            SetVolatileServerVariable('[Besieged]GeneralsCaptured', bit.bxor(case.standing, 31))
            xi.besieged.startSiegeEvent(player, { stronghold = xi.besieged.stronghold.HALVUNG, outcome = xi.besieged.outcome.START })
            player.packets:clear()
            player.events:update(11, 5)

            local reply = lastUpdate(player)
            assert(reply[0] == case.standing, string.format('Expected generals %d, got %d', case.standing, reply[0]))
            assert(reply[1] == case.seals, string.format('Expected %d seals, got %d', case.seals, reply[1]))

            player.events:finish(11, 5)
        end
    end)

    it('moves the player where the opening places them', function()
        xi.besieged.startSiegeEvent(player, { stronghold = xi.besieged.stronghold.ARRAPAGO, outcome = xi.besieged.outcome.START })

        local reply, moved = player.events:updateWithPosition(5, 5, { x = 54.229, y = 0.000, z = 119.506 })
        assert(reply == 31, 'Generals standing not sent after the move')
        assert(moved, 'The player was not moved')

        player.events:finish(5, 5)
    end)

    it('switches to the siege music at the opening and back after a win', function()
        xi.besieged.startSiegeEvent(player, { stronghold = xi.besieged.stronghold.MAMOOK, outcome = xi.besieged.outcome.START })
        assert(musicChanges(player)[xi.musicSlot.COMBAT_PARTY] == fatedStrife, 'Siege music not set')
        player.events:expect({ eventId = 8, finishOption = 5 })

        player.packets:clear()
        xi.besieged.startSiegeEvent(player, { stronghold = xi.besieged.stronghold.MAMOOK, outcome = xi.besieged.outcome.WIN })
        player.events:expect({ eventId = 9, updates = { 5 }, finishOption = 5 })

        local tracks = musicChanges(player)
        for _, slot in ipairs(musicSlots) do
            assert(tracks[slot] == bustleOfTheCapital, string.format('Town music not restored on slot %d', slot))
        end
    end)

    it('plays the loss event without changing music until it ends', function()
        xi.besieged.startSiegeEvent(player, { stronghold = xi.besieged.stronghold.ARRAPAGO, outcome = xi.besieged.outcome.LOSS })
        assert(next(musicChanges(player)) == nil, 'Music changed before the loss event ended')

        player.events:expect({ eventId = 7, finishOption = 5 })
        assert(musicChanges(player)[xi.musicSlot.ZONE_DAY] == bustleOfTheCapital, 'Town music not restored')
    end)
end)
