-----------------------------------
-- Report records, retirement replays, foreign stables and feeding refusals.
-- One raising day is one Earth day; 25 Vana'diel days pass in it.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local cutscenes = xi.chocoboRaising.cutscenes
local stages    = xi.chocoboRaising.stage
local plans     = xi.chocoboRaising.carePlans
local sandoria  = xi.chocoboRaising.raisingLocation[xi.zone.SOUTHERN_SAN_DORIA]

-- True when the trainer said the message since the last clear.
local function trainerSaid(player, trainer, messageId)
    local speaker = player.entities:get(trainer):getID()

    for _, packet in ipairs(player.packets:getIncoming()) do
        if
            packet.type == 0x02A and
            raisingClient.readU32(packet.data, 0x04) == speaker and
            bit.band(packet.data[0x1A] + packet.data[0x1B] * 256, 0x7FFF) == messageId
        then
            return true
        end
    end

    return false
end

describe('Chocobo raising report condenser', function()
    local basic = cutscenes.REPORT_BASIC_CARE

    local function day(number, scenes, outcome, conditions)
        return { number, scenes, outcome or { gil = 0, good = 1, poor = 0 }, conditions or 0 }
    end

    local function expectRecord(record, first, last, scenes)
        assert(record[1] == first and record[2] == last, string.format('Expected days %d-%d, got %d-%d', first, last, record[1], record[2]))
        assert(#record[3] == #scenes, string.format('Days %d-%d: expected %d cutscenes, got %d', first, last, #scenes, #record[3]))

        for index, scene in ipairs(scenes) do
            assert(record[3][index] == scene, string.format('Days %d-%d: cutscene %d is %d, expected %d', first, last, index, record[3][index], scene))
        end
    end

    it('folds days into records of one plan, at most seven days long, and adds up their totals', function()
        local records = xi.chocoboRaising.condenseEvents({
            day(1, { basic }),
            day(2, { basic }),
            day(3, { basic }),
            day(4, { basic, cutscenes.EGG_HATCHING }),
            day(5, { basic }),
        })

        assert(#records == 2, string.format('Folding: expected two records, got %d', #records))
        expectRecord(records[1], 1, 4, { basic, cutscenes.EGG_HATCHING })
        expectRecord(records[2], 5, 5, { basic })

        local events = {}
        for number = 22, 30 do
            table.insert(events, day(number, { basic }))
        end

        records = xi.chocoboRaising.condenseEvents(events)

        assert(#records == 2, string.format('Seven day cap: expected two records, got %d', #records))
        expectRecord(records[1], 22, 28, { basic })
        expectRecord(records[2], 29, 30, { basic })

        local walk = plans.TAKING_A_WALK
        records    = xi.chocoboRaising.condenseEvents({
            day(1, { basic }),
            day(2, { walk }),
            day(3, { walk, cutscenes.CRYING_AT_NIGHT }),
        })

        assert(#records == 2, string.format('Plan change: expected two records, got %d', #records))
        expectRecord(records[1], 1, 1, { basic })
        expectRecord(records[2], 2, 3, { walk, cutscenes.CRYING_AT_NIGHT })

        records = xi.chocoboRaising.condenseEvents({
            day(1, { basic }, { gil = 10, good = 1, poor = 0 }, 0x1),
            day(2, { basic }, { gil = 20, good = 0, poor = 1 }, 0x4),
            day(3, { basic, cutscenes.CRYING_AT_NIGHT }, { gil = 5, good = 1, poor = 0 }, 0x800),
        })

        assert(#records == 1, string.format('Totals: expected one record, got %d', #records))

        local totals = records[1][4]
        assert(totals.gil == 35 and totals.good == 2 and totals.poor == 1, string.format('Expected 35 gil, 2 good, 1 poor, got %d, %d, %d', totals.gil, totals.good, totals.poor))
        assert(records[1][5] == 0x805, string.format('Expected conditions 0x805, got 0x%X', records[1][5]))
    end)
end)

describe('Chocobo raising report', function()
    ---@type CClientEntityPair
    local player
    ---@type RaisingClient
    local client

    -- Moves the chocobo back so that `day` is its last reported day.
    local function placeOnDay(dayNumber, stage, fields)
        local info = player:getChocoboRaisingInfo()
        xi.chocoboRaising.model.moveTime(info, dayNumber, xi.chocoboRaising.dayLength)
        info.last_update_age = dayNumber + 1
        info.stage           = stage

        for key, value in pairs(fields or {}) do
            info[key] = value
        end

        player:setChocoboRaisingInfo(info)
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:setGMLevel(0)
        player:deleteRaisedChocobo()
        player:setCharVar(xi.chocoboRaising.retirement.heldItemsVar, 0)

        -- The lowest roll gives good days and starts no condition.
        stub('math.randomInt', 1)

        client = raisingClient.tradeEgg(player)
    end)

    after_each(function()
        player:deleteRaisedChocobo()
        player:setCharVar(xi.chocoboRaising.retirement.heldItemsVar, 0)
    end)

    describe('retirement', function()
        local function reachRetirementUnplayed()
            placeOnDay(128, stages.ADULT_3, { first_name = 'Test', last_name = 'Bird', color = xi.chocoboRaising.color.BLUE })
            xi.test.world:skipVanaDays(25)

            -- Walks away before the report.
            raisingClient.talk(client)
            raisingClient.finish(client, 0)

            assert(player:getChocoboRaisingInfo().stage == stages.ADULT_4, 'Expected the retired stage saved')
        end

        it('replays the retirement on the next visit', function()
            reachRetirementUnplayed()

            local visit = raisingClient.visit(client)
            assert(visit.retired and raisingClient.heard(visit, cutscenes.ADULT_3_TO_ADULT_4), 'Expected the retirement replayed')
            assert(#visit.records == 1 and visit.records[1].startDay == 129 and visit.records[1].endDay == 129, 'Expected one record for day 129')

            assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo gone')
            player.assert:hasItem(xi.item.VCS_REGISTRATION_CARD)
            player.assert:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
        end)

        it('holds what does not fit after a replayed retirement', function()
            reachRetirementUnplayed()
            raisingClient.leaveFreeSlots(player, 1)

            local visit = raisingClient.visit(client)
            assert(visit.retired, 'Expected the retirement replayed')
            player.assert:hasItem(xi.item.VCS_REGISTRATION_CARD)
            player.assert.no:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
            assert(xi.chocoboRaising.retirement.hasHeldItems(player), 'Expected the plaque held')

            raisingClient.leaveFreeSlots(player, 1)
            local start = raisingClient.talk(client)
            assert(start.eventId == xi.chocoboRaising.retirement.events[xi.zone.SOUTHERN_SAN_DORIA], 'Expected the hand-over event')
            raisingClient.finish(client, 0)

            player.assert:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
            assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo gone')
        end)
    end)

    describe('another stable', function()
        it('keeps the days for the chocobo\'s own stable', function()
            xi.test.world:skipVanaDays(25 * 2)

            raisingClient.gotoZone(player, xi.zone.BASTOK_MINES)

            local zopago = raisingClient.new(player)

            local start = raisingClient.talk(zopago)
            assert(start.eventId == 508, string.format('Expected the reminder event 508, got %d', start.eventId))
            raisingClient.finish(zopago, 0)

            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            start = raisingClient.trade(zopago, { xi.item.BUNCH_OF_GYSAHL_GREENS })
            assert(start.eventId == 508, string.format('Expected the reminder event 508, got %d', start.eventId))
            raisingClient.finish(zopago, 0)

            player:addItem(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
            start = raisingClient.trade(zopago, { xi.item.CHOCOBO_EGG_FAINTLY_WARM })
            assert(start.eventId == 515, string.format('Expected the rejection event 515, got %d', start.eventId))
            raisingClient.expectReply('515 start', start.params, { sandoria })
            raisingClient.finish(zopago, 0)

            assert(player:getChocoboRaisingInfo().last_update_age == 1, 'Expected no day applied at another stable')

            raisingClient.gotoZone(player, xi.zone.SOUTHERN_SAN_DORIA)

            local visit = raisingClient.visit(client)
            assert(#visit.records == 1 and visit.records[1].startDay == 1 and visit.records[1].endDay == 2, 'Expected days 1-2 reported at home')
        end)
    end)

    it('saves nothing at a visit with no new day, and falls back to Basic Care for an unknown locked plan', function()
        xi.test.world:skipVanaDays(25)
        raisingClient.visit(client)

        local saves = spy('xi.chocoboRaising.updateChocoState')
        raisingClient.talk(client)
        saves:called(0)
        raisingClient.finish(client, 0)

        raisingClient.setChocobo(player, { locked_plan = 31 })

        raisingClient.talk(client)
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().locked_plan == plans.BASIC_CARE, 'Expected Basic Care locked')
    end)

    describe('playout', function()
        it('groups the first four days and counts the record\'s cutscenes', function()
            xi.test.world:skipVanaDays(25 * 4)

            local visit = raisingClient.visit(client)
            assert(#visit.records == 1 and visit.records[1].startDay == 1 and visit.records[1].endDay == 4, 'Expected one record for days 1-4')

            local scene = sandoria * 256
            raisingClient.expectReply('plan 246', visit.cutsceneReplies[1], { 1, scene + cutscenes.REPORT_BASIC_CARE, 0, 2, stages.EGG })
            raisingClient.expectReply('hatch 246', visit.cutsceneReplies[2], { 0, scene + cutscenes.EGG_HATCHING, 0, 2, stages.CHICK })
        end)

        it('reports four good days in one record', function()
            xi.test.world:skipVanaDays(25 * 4)

            raisingClient.talk(client)
            raisingClient.send(client, 244)
            raisingClient.send(client, 208)
            raisingClient.expectReply('248', raisingClient.send(client, 248), { 248, 1 + bit.lshift(4, 10) + bit.lshift(4, 20), 2, 0x40000, stages.EGG, 0, 0, 0 })
            raisingClient.finish(client, 0)
        end)
    end)

    describe('forced naming', function()
        it('names the chocobo after the growth scene without a reply', function()
            placeOnDay(63, stages.ADULT_2)
            xi.test.world:skipVanaDays(25)

            raisingClient.talk(client)
            raisingClient.send(client, 244)
            raisingClient.send(client, 208)

            local record = raisingClient.send(client, 248)
            assert(record[5] == 0, 'Expected the growth record to show the chocobo unnamed')

            for _ = 1, record[2] do
                raisingClient.send(client, 246)
            end

            local forced  = player:getChocoboRaisingInfo().first_name
            local strings = raisingClient.strings(client)
            assert(forced ~= 'Chocobo', 'Expected the trainer\'s name')
            assert(strings and strings[0] == forced, string.format('Expected the event strings to carry %s', forced))

            player.packets:clear()
            player.events:update(nil, 216)
            assert(#raisingClient.replies(client) == 0, 'Expected no reply to the forced naming')
            assert(player:isInEvent(), 'Expected the event to go on')
            assert(player:getChocoboRaisingInfo().first_name == forced, 'Expected the forced name kept')

            raisingClient.finish(client, 0)
        end)
    end)

    describe('feeding', function()
        local trainer = 'Hantileon'
        -- The trainer's lines, not the system messages 10753-10755.
        local refusal =
        {
            SLEEP     = 11302,
            RUN_AWAY  = 11303,
            STILL_EGG = 11304,
        }

        local function refusedWith(messageId)
            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            player.packets:clear()
            player.actions:tradeNpc(trainer, { xi.item.BUNCH_OF_GYSAHL_GREENS })

            player.events:expectNotInEvent()
            player.assert:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            assert(trainerSaid(player, trainer, messageId), string.format('Expected %s to say message %d', trainer, messageId))
        end

        it('refuses food for an egg, and while the chocobo sleeps or is away', function()
            refusedWith(refusal.STILL_EGG)

            xi.test.world:skipVanaDays(25 * 4)
            raisingClient.visit(client)

            raisingClient.setChocobo(player, { conditions = bit.lshift(1, xi.chocoboRaising.conditions.SLEEPING) })
            refusedWith(refusal.SLEEP)

            raisingClient.setChocobo(player, { conditions = bit.lshift(1, xi.chocoboRaising.conditions.RUN_AWAY) })
            refusedWith(refusal.RUN_AWAY)
        end)

        it('feeds a chocobo with Rest locked', function()
            xi.test.world:skipVanaDays(25 * 4)
            raisingClient.visit(client)
            raisingClient.setChocobo(player, { locked_plan = plans.RESTING })

            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            local start = raisingClient.trade(client, { xi.item.BUNCH_OF_GYSAHL_GREENS })
            assert(start.eventId == client.csid, 'Expected the feeding event')
            raisingClient.send(client, 241)
            raisingClient.finish(client, 0)

            player.assert.no:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
        end)
    end)

    describe('egg rejection', function()
        it('answers 244 with the chocobo\'s stage', function()
            raisingClient.setChocobo(player, { stage = stages.CHICK })

            player:addItem(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
            local start = raisingClient.trade(client, { xi.item.CHOCOBO_EGG_FAINTLY_WARM })
            assert(start.eventId == 831, string.format('Expected the rejection event 831, got %d', start.eventId))

            raisingClient.expectReply('831 244', raisingClient.send(client, 244), { 0, 0, 0, 0, stages.CHICK, 1, 0, 0 })
            raisingClient.finish(client, 0)
        end)
    end)
end)
