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

describe('Chocobo Circuit betting', function()
    local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

    -- Lanes 3 and 7, pair 17.
    local pick  = 1 + 2 * 8 + 6 * 128
    local buy   = 2 + 2 * 8 + 6 * 128
    local pair  = 17
    local quill = 2048

    -- Counter selling the race this many after the next one to close.
    local function counterAhead(races)
        local raceNo = xi.chocoboRacing.raceNoAt(GetSystemTime() - xi.chocoboRacing.schedule.BETS_CLOSE) + 1 + races
        xi.chocoboRacing.postRace(raceNo)

        return zones[xi.zone.CHOCOBO_CIRCUIT].npc.COUNTER_OFFSET + 16 + xi.chocoboRacing.getRaceColor(raceNo), raceNo
    end

    it('sells a ticket', function()
        local player          = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        local counter, raceNo = counterAhead(0)
        local client          = raisingClient.forNPC(player, counter)
        local before          = GetChocoboRaceQuills(raceNo)[pair]
        player:setGil(5000)

        local start = raisingClient.talk(client)
        assert(start.params[0] == xi.chocoboRacing.getRaceId(raceNo), 'wrong race')
        assert(start.params[7] == xi.chocoboRacing.getRaceColor(raceNo))

        local picked = raisingClient.send(client, pick)
        assert(picked[2] == xi.chocoboRacing.getOdds(raceNo)[pair])

        local bought = raisingClient.send(client, buy + 10 * quill)
        assert(bought[0] == xi.chocoboRacing.buyResult.SOLD and bought[2] == 1000)
        assert(player:getGil() == 4000)
        assert(player:hasKeyItem(xi.keyItem.CHOCOBO_CIRCUIT_GRANDSTAND_PASS))
        assert(GetChocoboRaceQuills(raceNo)[pair] == before + 10)

        local ticket = assert(player:findItem(xi.item.CHOCOBET_TICKET)):getExData()
        assert(ticket.raceId == xi.chocoboRacing.shownRaceNo(raceNo) and ticket.raceGrade == xi.chocoboRacing.getRaceGrade(raceNo))
        assert(ticket.racePairingL == 2 and ticket.racePairingR == 6 and ticket.quills == 10)

        local total = 0
        for _, quills in ipairs(GetChocoboRaceQuills(raceNo)) do
            total = total + quills
        end

        assert(xi.chocoboRacing.getOdds(raceNo)[pair] == math.min(math.floor(75 * total / (before + 10)), 49999))
        raisingClient.finish(client, buy + 10 * quill)
    end)

    it('rejects invalid bets', function()
        local player  = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        local client  = raisingClient.forNPC(player, (counterAhead(1)))
        local sameTwo = 2 + 2 * 8 + 2 * 128
        player:setGil(5000)

        raisingClient.talk(client)
        for _, option in ipairs({ sameTwo + quill, buy, buy + 1000 * quill, buy + 51 * quill, buy + 13 * 8 + quill }) do
            assert(raisingClient.send(client, option)[0] == xi.chocoboRacing.buyResult.ERROR, string.format('option %d accepted', option))
        end

        assert(player:getGil() == 5000)
        assert(not player:findItem(xi.item.CHOCOBET_TICKET))

        raisingClient.leaveFreeSlots(player, 0)
        assert(raisingClient.send(client, buy + quill)[0] == xi.item.CHOCOBET_TICKET)
        assert(player:getGil() == 5000)
        raisingClient.finish(client)
    end)

    it('sells nothing when closed', function()
        local player  = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        local counter = counterAhead(2)
        local client  = raisingClient.forNPC(player, counter)
        player:setGil(5000)

        local open   = raisingClient.forNPC(player, (counterAhead(0)))
        local closed = raisingClient.talk(client)
        raisingClient.finish(client)
        assert(closed.eventId ~= raisingClient.talk(open).eventId and not closed.params[0], 'counter not closed')
        raisingClient.finish(open)

        raisingClient.talk(client)
        assert(raisingClient.send(client, buy + quill)[0] == xi.chocoboRacing.buyResult.CLOSED)
        assert(player:getGil() == 5000)
        raisingClient.finish(client)
    end)

    -- Buys 10 quills on 3-7, then ends the race with these places.
    local function ticketOn(places)
        local player          = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        local counter, raceNo = counterAhead(0)
        local client          = raisingClient.forNPC(player, counter)
        player:setGil(1000)

        raisingClient.talk(client)
        assert(raisingClient.send(client, buy + 10 * quill)[0] == xi.chocoboRacing.buyResult.SOLD)
        raisingClient.finish(client)

        -- Too early to cash in.
        player.packets:clear()
        player.actions:tradeNpc(counter, { xi.item.CHOCOBET_TICKET })
        player.events:expectNotInEvent()
        assert(said(player, counter, zones[xi.zone.CHOCOBO_CIRCUIT].text.RACE_NOT_DECIDED))
        assert(player:findItem(xi.item.CHOCOBET_TICKET))

        xi.test.world:skipVanaDays(1)

        local race = xi.chocoboRacing.runRace(raceNo)
        race.places = places
        SaveChocoboRaceResult(race)
        assert(GetChocoboRaceQuills(raceNo)[pair] >= 10, 'saving the race lost its bets')

        return player, client, race
    end

    it('pays a winning ticket', function()
        local player, client, race = ticketOn({ 2, 3, 0, 4, 5, 6, 1, 7 })
        local payout               = xi.chocoboRacing.getQuinella(race).payout

        local start = raisingClient.trade(client, { xi.item.CHOCOBET_TICKET })
        raisingClient.expectReply('ticket', start.params, { payout * 10, xi.chocoboRacing.getRaceId(race.raceNo), 2, 6, xi.chocoboRacing.ticketStatus.WINNER })
        raisingClient.expectReply('result', raisingClient.send(client, 1), { payout, 3, 7, nil, xi.chocoboRacing.ticketStatus.WINNER, nil, nil, 0 })

        -- A winner can't be disposed of.
        raisingClient.finish(client, xi.chocoboRacing.ticketOption.DISPOSE)
        assert(player:getGil() == 0 and player:findItem(xi.item.CHOCOBET_TICKET))

        raisingClient.trade(client, { xi.item.CHOCOBET_TICKET })
        raisingClient.finish(client, xi.chocoboRacing.ticketOption.COLLECT)
        assert(player:getGil() == payout * 10)
        assert(not player:findItem(xi.item.CHOCOBET_TICKET))
    end)

    it('takes a losing ticket without paying', function()
        local player, client = ticketOn({ 0, 1, 2, 3, 4, 5, 6, 7 })

        local start = raisingClient.trade(client, { xi.item.CHOCOBET_TICKET })
        assert(start.params[0] == 0 and start.params[4] == xi.chocoboRacing.ticketStatus.LOSER)
        raisingClient.finish(client, xi.chocoboRacing.ticketOption.COLLECT)
        assert(player:getGil() == 0 and player:findItem(xi.item.CHOCOBET_TICKET))

        raisingClient.trade(client, { xi.item.CHOCOBET_TICKET })
        raisingClient.finish(client, xi.chocoboRacing.ticketOption.DISPOSE)
        assert(player:getGil() == 0 and not player:findItem(xi.item.CHOCOBET_TICKET))
    end)

    it('does not pay an expired ticket', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.CHOCOBO_CIRCUIT })
        local client = raisingClient.forNPC(player, (counterAhead(0)))
        local raceNo = xi.chocoboRacing.currentRaceNo() - 673
        player:setGil(0)

        assert(player:addItem({ id = xi.item.CHOCOBET_TICKET, silent = true })):setExData({
            raceId       = xi.chocoboRacing.shownRaceNo(raceNo),
            raceGrade    = xi.chocoboRacing.getRaceGrade(raceNo),
            racePairingL = 2,
            racePairingR = 6,
            quills       = 999,
        })

        assert(raisingClient.trade(client, { xi.item.CHOCOBET_TICKET }).params[4] == xi.chocoboRacing.ticketStatus.EXPIRED)
        raisingClient.finish(client, xi.chocoboRacing.ticketOption.COLLECT)
        assert(player:getGil() == 0 and player:findItem(xi.item.CHOCOBET_TICKET))
    end)
end)
