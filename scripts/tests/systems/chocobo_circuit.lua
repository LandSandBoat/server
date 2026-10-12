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

-- The clock only moves in whole Vana'diel days (3456 seconds), so skip days until it lands just after a race start.
local function skipToRaceStart()
    local days = 1
    while (GetSystemTime() + 3456 * days - 360) % 900 >= 36 do
        days = days + 1
    end

    xi.test.world:skipVanaDays(days)
    xi.test.world:tick()
end

describe('Chocobo Circuit race', function()
    it('posts a field without a result, then saves the result when the race runs', function()
        -- Far past any real race number, so no saved row matches.
        local raceNo = GetSystemTime()

        xi.chocoboRacing.postRace(raceNo)
        local posted = LoadChocoboRaceResult(raceNo)
        assert(posted and posted.runAt == 0)

        local race   = xi.chocoboRacing.runRace(raceNo)
        local loaded = assert(LoadChocoboRaceResult(raceNo))
        local places = assert(race.places)
        local final  = assert(race.sections)[32]
        assert(loaded.runAt > 0)
        for lane = 1, 8 do
            assert(loaded.chocobos[lane].name == posted.chocobos[lane].name, 'the field must not change when the race runs')
            assert(assert(loaded.places)[lane] == places[lane])
            assert(assert(loaded.sections)[32].to[lane] == final.to[lane])
        end
    end)

    it('shows the race only to players in the grandstand', function()
        local spectator = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        local passerby  = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        spectator:setPos(-59, -14, -124)
        passerby:setPos(-325, 0, -486)

        local raceNo = xi.chocoboRacing.currentRaceNo()
        xi.chocoboRacing.runRace(raceNo)
        xi.chocoboRacing.broadcastRace({ spectator, passerby }, raceNo)

        passerby.events:expectNotInEvent()
        spectator.events:expect({ eventId = 210, updates = { 5, 274, 530, 17 }, finishOption = 0 })
        spectator.events:expectNotInEvent()
    end)

    it('starts each race on schedule for the grandstand', function()
        local spectator = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        spectator:setPos(-59, -14, -124)
        xi.test.world:tick()

        skipToRaceStart()

        local raceNo = xi.chocoboRacing.currentRaceNo()
        local result = LoadChocoboRaceResult(raceNo)
        assert(result and result.runAt > 0, 'race was not run')
        spectator.events:expect({ eventId = 210, updates = { 5 }, finishOption = 0 })
    end)
end)

describe('Chocobo Circuit announcements', function()
    it('calls each race start on schedule to the whole zone', function()
        local ID       = zones[xi.zone.CHOCOBO_CIRCUIT]
        local passerby = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        passerby:setPos(-325, 0, -486)
        xi.test.world:tick()

        skipToRaceStart()

        local master = ID.npc.MASTER_OFFSET + xi.chocoboRacing.getRaceColor(xi.chocoboRacing.currentRaceNo())
        assert(said(passerby, master, ID.text.RACE_STARTING), 'race start was not called')
        assert(said(passerby, master, ID.text.RACE_STARTING_END), 'race start footer was not called')
    end)
end)
