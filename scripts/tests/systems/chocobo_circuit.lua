-- True when the speaker said the message since the last clear.
---@param player CClientEntityPair
---@param speakerId integer
---@param messageId integer
---@return boolean
local function said(player, speakerId, messageId)
    for _, packet in ipairs(player.packets:getIncoming()) do
        if
            packet.type == 0x036 and
            packet.data[0x04] + packet.data[0x05] * 256 + packet.data[0x06] * 65536 + packet.data[0x07] * 16777216 == speakerId and
            bit.band(packet.data[0x0A] + packet.data[0x0B] * 256, 0x7FFF) == messageId
        then
            return true
        end
    end

    return false
end

describe('Chocobo Circuit announcements', function()
    it('calls each race start on schedule to the whole zone', function()
        local ID       = zones[xi.zone.CHOCOBO_CIRCUIT]
        local passerby = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        passerby:setPos(-325, 0, -486)
        xi.test.world:tick()

        -- Races follow the Earth clock, which only whole Vana'diel days move: 3456 seconds each, 756 past a 15 minute slot.
        -- Some count of days from 1 to 25 lands between 1 and 36 seconds after a race start; at least one so the clock moves past the primed tick.
        local days = 1
        while (GetSystemTime() + 3456 * days - 360) % 900 >= 36 do
            days = days + 1
        end

        xi.test.world:skipVanaDays(days)
        xi.test.world:tick()

        local master = ID.npc.MASTER_OFFSET + xi.chocoboRacing.getRaceColor(xi.chocoboRacing.currentRaceNo())
        assert(said(passerby, master, ID.text.RACE_STARTING), 'race start was not called')
        assert(said(passerby, master, ID.text.RACE_STARTING_END), 'race start footer was not called')
    end)
end)
