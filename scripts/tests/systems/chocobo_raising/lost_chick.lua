-----------------------------------
-- The lost chick, Dietmund, and receptivity raising the meeting chance.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local walks     = xi.chocoboRaising.walks
local effect    = xi.chocoboRaising.effect
local trainer   = xi.chocoboRaising.walkTrainer
local cutscenes = xi.chocoboRaising.cutscenes
local walkEvent = walks.walkEvent
local results   = walks.lostChickResult

local sandoria = 1

local shortWalk   = cutscenes.GO_ON_A_WALK_SHORT
local regularWalk = cutscenes.GO_ON_A_WALK_REGULAR
local longWalk    = cutscenes.GO_ON_A_WALK_LONG

-- A care action option carries its cutscene in the second byte.
local shortWalkOption = 242 + shortWalk * 256
local longWalkOption  = 242 + longWalk * 256

local diligentStory = xi.keyItem.STORY_OF_A_DILIGENT_CHOCOBO

local scriptedRolls = helpers.scriptedRolls
local hasEffect     = helpers.hasEffect

local function newState(stage)
    return
    {
        stage         = stage or xi.chocoboRaising.stage.CHICK,
        held_item     = 0,
        walk_progress = 0,
        receptivity   = 0,
    }
end

-- A chick found at San d'Oria for `owner`, with `clues` given.
local function chickValue(owner, clues, solved)
    local chick    = walks.lostChick(0)
    chick.owner    = owner or 0
    chick.clues    = clues or 0
    chick.location = sandoria
    chick.solved   = solved or false

    if chick.owner == 0 then
        chick.location = 0
    end

    return walks.packLostChick(chick)
end

local function varAfter(value, effects, varName)
    for _, entry in ipairs(effects) do
        if entry[1] == effect.SET_CHAR_VAR and entry[2] == varName then
            value = entry[3]
        end
    end

    return value
end

-- The stubbed math.randomInt answers with this.
local currentRolls = helpers.lowestRoll

-- Walks once, answering its rolls from `rolls`, and returns the reply fields and the lost chick value after it.
local function walk(state, careAction, value, rolls, canMeetDietmund)
    currentRolls = scriptedRolls(rolls)

    local ctx =
    {
        location        = sandoria,
        walkZone        = 0,
        lostChick       = value,
        canMeetDietmund = canMeetDietmund,
    }

    local result, effects = walks.walk(state, careAction, ctx)

    return result, varAfter(value, effects, walks.lostChickVar), effects
end

describe('Chocobo raising lost chick', function()
    describe('rules', function()
        before_each(function()
            currentRolls = helpers.lowestRoll
            stub('math.randomInt', function(low, high)
                return currentRolls(low, high)
            end)
        end)

        it('finds the chick only on a chick\'s short walk that finds nothing, with no chick lost or solved', function()
            local result, value = walk(newState(), shortWalk, 0, { 100, 6 })
            local chick         = walks.lostChick(value)

            assert(result.event == walkEvent.LOST_CHICK and result.data == 0 and result.trainer == 0, 'Expected the find with p3 0')
            assert(chick.owner == 6 and chick.location == sandoria, string.format('Expected owner 6 at San d\'Oria, got %d at %d', chick.owner, chick.location))

            local meeting = walk(newState(), shortWalk, 0, { 1 })
            assert(meeting.event == 0 and meeting.trainer == trainer.HANTILEON, 'Expected a plain meeting')

            local adolescent = walk(newState(xi.chocoboRaising.stage.ADOLESCENT), shortWalk, 0, { 100 })
            assert(adolescent.event == 0, 'Expected no find past the chick stage')

            local lost = walk(newState(), shortWalk, chickValue(6), { 100 })
            assert(lost.event == 0, 'Expected no second chick')

            local solved = walk(newState(), shortWalk, chickValue(0, 0, true), { 100 })
            assert(solved.event == 0, 'Expected no chick once solved')
        end)

        it('gives the letter, race and job in order, then asks about the owner', function()
            local state = newState()
            local value = chickValue(6)

            -- Hantileon on short walks, Pulonono on long walks; p3 counts that trainer's earlier clues.
            local steps =
            {
                { shortWalk, walkEvent.LETTER,    0x600, trainer.HANTILEON },
                { shortWalk, walkEvent.RACE,      0x601, trainer.HANTILEON },
                { longWalk,  walkEvent.JOB,       0x600, trainer.PULONONO },
                { shortWalk, walkEvent.ALL_CLUES, 0x602, trainer.HANTILEON },
                { longWalk,  walkEvent.ALL_CLUES, 0x601, trainer.PULONONO },
            }

            for index, step in ipairs(steps) do
                local result
                result, value = walk(state, step[1], value, { 1, 1 })

                assert(result.trainer == step[4], string.format('Step %d: expected trainer %d, got %d', index, step[4], result.trainer))
                assert(result.event == step[2] and result.data == step[3], string.format('Step %d: expected p2 %d p3 %d, got %d %d', index, step[2], step[3], result.event, result.data))
            end

            assert(walks.lostChick(value).clues == 3, 'Expected three clues')
        end)

        it('gets no clue from the rivals, at another stable or from Dietmund', function()
            local rivals, rivalsValue = walk(newState(), regularWalk, chickValue(6), { 1, 1 })

            assert(rivals.trainer == trainer.RIVALS and rivals.event == 0 and rivals.data == 0, 'Expected the rivals without a clue')
            assert(walks.lostChick(rivalsValue).clues == 0, 'Expected no clue stored from the rivals')

            local windurst = 3
            local value    = chickValue(6)
            local ctx      =
            {
                location  = windurst,
                walkZone  = 0,
                lostChick = value,
            }

            currentRolls = scriptedRolls({ 1, 1 })

            local elsewhere, effects = walks.walk(newState(), shortWalk, ctx)

            assert(elsewhere.trainer == trainer.PULONONO, string.format('Expected Pulonono, got %d', elsewhere.trainer))
            assert(elsewhere.event == 0 and elsewhere.data == 0, string.format('Expected no clue, got p2 %d p3 %d', elsewhere.event, elsewhere.data))
            assert(varAfter(value, effects, walks.lostChickVar) == value, 'Expected the lost chick unchanged at another stable')

            local dietmund, dietmundValue = walk(newState(xi.chocoboRaising.stage.ADULT_1), longWalk, chickValue(6), { 1, 3 }, true)

            assert(dietmund.trainer == trainer.DIETMUND and dietmund.event == 0 and dietmund.data == 0, 'Expected no clue from Dietmund')
            assert(walks.lostChick(dietmundValue).clues == 0, 'Expected no clue stored from Dietmund')
        end)

        it('shows the clerk the clues found', function()
            local none = walks.clerkReview(chickValue(6), sandoria)
            assert(none[0] == 0 and none[6] == 0, 'Expected no review before a clue')

            local one = walks.clerkReview(chickValue(6, 1), sandoria)
            assert(one[0] == 1 and one[3] == 1 and one[4] == 0 and one[5] == 0 and one[6] == 6, 'Expected the letter and owner 6')

            local all = walks.clerkReview(chickValue(6, 3), sandoria)
            assert(all[3] == 1 and all[4] == 1 and all[5] == 1, 'Expected all three clues')

            local elsewhere = walks.clerkReview(chickValue(6, 3), 2)
            assert(elsewhere[0] == 0, 'Expected another stable\'s clerk to know nothing')
        end)

        it('teaches the diligent story for the right owner and resets the quest on a wrong one', function()
            local right, effects = walks.askOwner(chickValue(6, 3), sandoria, 6)
            local chick          = walks.lostChick(varAfter(0, effects, walks.lostChickVar))

            assert(right, 'Expected the right owner')
            assert(hasEffect(effects, effect.ADD_KEY_ITEM, diligentStory), 'Expected the diligent story')
            assert(chick.owner == 0 and chick.solved and chick.result == results.RETURNED, 'Expected solved and returned')

            local later = walk(newState(), shortWalk, walks.packLostChick(chick), { 100 })
            assert(later.event == 0, 'Expected no chick after solving')

            local wrong, wrongEffects = walks.askOwner(chickValue(6, 3), sandoria, 4)
            local value               = varAfter(0, wrongEffects, walks.lostChickVar)
            local reset               = walks.lostChick(value)

            assert(not wrong, 'Expected the wrong owner')
            assert(not hasEffect(wrongEffects, effect.ADD_KEY_ITEM, diligentStory), 'Expected no story')
            assert(reset.owner == 0 and reset.clues == 0 and not reset.solved and reset.result == results.WRONG_OWNER, 'Expected a reset')

            local again = walk(newState(), shortWalk, value, { 100, 2 })
            assert(again.event == walkEvent.LOST_CHICK, 'Expected a later short walk to find a chick again')
        end)

        it('meets Dietmund on a long walk only when allowed', function()
            local result, _, effects = walk(newState(xi.chocoboRaising.stage.ADULT_1), longWalk, 0, { 1, 3 }, true)

            assert(result.trainer == trainer.DIETMUND and result.meeting == 0 and result.event == 0, 'Expected Dietmund, meeting 0')
            assert(hasEffect(effects, effect.SET_USER_FLAG, xi.chocoboRaising.userFlag.MET_DIETMUND), 'Expected the met flag')

            local barred = walk(newState(xi.chocoboRaising.stage.ADULT_1), longWalk, 0, { 1, 3 }, false)
            assert(barred.trainer == trainer.BRUTUS, 'Expected no Dietmund without the gate')

            local regular = walks.candidates(sandoria, regularWalk, true)
            assert(#regular == 2, 'Expected Dietmund only on long walks')
        end)

        it('adds 1% meeting chance per 16 receptivity above 63', function()
            local state = newState()
            local base  = walks.eventChance[shortWalk][1]

            local expected = { [0] = base, [63] = base, [78] = base, [79] = base + 1, [255] = base + 12 }
            for receptivity, chance in pairs(expected) do
                state.receptivity = receptivity
                assert(walks.meetingChance(state, shortWalk) == chance, string.format('Receptivity %d: expected %d', receptivity, chance))
            end

            state.receptivity = 63
            assert(walk(state, shortWalk, chickValue(0, 0, true), { base + 1 }).trainer == 0, 'Expected no meeting at 63')

            state.receptivity = 79
            assert(walk(state, shortWalk, chickValue(0, 0, true), { base + 1 }).trainer == trainer.HANTILEON, 'Expected a meeting at 79')
        end)
    end)

    describe('in San d\'Oria', function()
        ---@type CClientEntityPair
        local player
        local client

        -- One stub per test; later calls refill its queue.
        local rollQueue

        local function stubRolls(rolls)
            if rollQueue then
                for index = #rollQueue, 1, -1 do
                    table.remove(rollQueue, index)
                end

                for _, roll in ipairs(rolls) do
                    table.insert(rollQueue, roll)
                end

                return
            end

            rollQueue = { unpack(rolls) }
            stub('math.randomInt', function(low, high)
                return utils.clamp(table.remove(rollQueue, 1) or low, low, high)
            end)
        end

        local function careAction(option)
            raisingClient.setChocobo(player, { energy = 100 })
            raisingClient.talk(client)
            raisingClient.send(client, 244)

            local reply = raisingClient.send(client, option)
            raisingClient.finish(client, 0)

            return reply
        end

        -- A chick on day 4 in clear weather.
        before_each(function()
            rollQueue = nil
            xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
            xi.test.world:setSeed(1)
            player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
            player:deleteRaisedChocobo()

            client = raisingClient.tradeEgg(player)

            xi.test.world:skipVanaDays(4 * 25)
            raisingClient.visit(client)

            stub('xi.chocoboRaising.getWeatherInZone', xi.weather.SUNSHINE)
        end)

        after_each(function()
            player:deleteRaisedChocobo()
        end)

        it('finds the chick, then hears the first clue from Hantileon', function()
            stubRolls({ 100, 6 })
            local find = careAction(shortWalkOption)
            assert(find[2] == walkEvent.LOST_CHICK and find[3] == 0, string.format('Expected p2 2 p3 0, got %d %d', find[2], find[3]))
            assert(walks.lostChick(player:getCharVar(walks.lostChickVar)).owner == 6, 'Expected owner 6 stored')

            stubRolls({ 1, 1 })
            local clue = careAction(shortWalkOption)
            assert(clue[2] == walkEvent.LETTER and clue[3] == 0x600 and clue[5] == trainer.HANTILEON, string.format('Expected [3, 1536] from Hantileon, got [%d, %d]', clue[2], clue[3]))
        end)

        it('lets Arvilauge review the clues', function()
            player:setCharVar(walks.lostChickVar, chickValue(6, 2))

            local start = raisingClient.talk(raisingClient.forNPC(player, 'Arvilauge', 846))
            player.events:finish()

            local params = start.params
            assert(start.eventId == 846, string.format('Expected event 846, got %d', start.eventId))
            assert(params[0] == 1 and params[3] == 1 and params[4] == 1 and params[5] == 0 and params[6] == 6, 'Expected [1, _, 0, 1, 1, 0, 6, 0]')
        end)

        it('teaches the diligent story at the right owner, then Hantileon reports it', function()
            player:setCharVar(walks.lostChickVar, chickValue(6, 3))

            local lanqueron = raisingClient.forNPC(player, 'Lanqueron', 850)
            local start     = raisingClient.talk(lanqueron)
            assert(start.eventId == 850, string.format('Expected event 850, got %d', start.eventId))

            local answer = raisingClient.send(lanqueron, 1)
            raisingClient.finish(lanqueron, 1)

            assert(answer[0] == 1, 'Expected the thanks branch')
            player.assert:hasKI(diligentStory)
            assert(walks.lostChick(player:getCharVar(walks.lostChickVar)).solved, 'Expected solved')

            local hantileon = raisingClient.forNPC(player, 'Hantileon', 852)
            local report    = raisingClient.talk(hantileon)
            assert(report.eventId == 852 and report.params[0] == 0 and report.params[1] == 1 and report.params[7] == sandoria, 'Expected 852 [0, 1, 0, 0, 0, 0, 0, 1]')
            raisingClient.finish(hantileon, 0)

            assert(walks.lostChick(player:getCharVar(walks.lostChickVar)).result == results.NONE, 'Expected the report played once')
            assert(raisingClient.talk(client).eventId == client.csid, 'Expected the main event next')
            raisingClient.finish(client, 0)
        end)

        -- Sends an option and returns how many event updates came back.
        local function sendRaw(option)
            player.packets:clear()
            player.events:update(nil, option)

            return #raisingClient.replies(client)
        end

        it('answers an inline owner\'s guess once, and only after the question inside the default event', function()
            local value = chickValue(1, 3)
            player:setCharVar(walks.lostChickVar, value)

            local coderiant = raisingClient.forNPC(player, 'Coderiant', 583)
            assert(raisingClient.talk(coderiant).eventId == 583, 'Expected event 583')

            assert(sendRaw(2) == 0, 'Expected no answer before the question')
            raisingClient.finish(coderiant, 0)

            assert(player:getCharVar(walks.lostChickVar) == value, 'Expected the search unchanged')
            player.assert.no:hasKI(diligentStory)

            assert(raisingClient.talk(coderiant).eventId == 583, 'Expected event 583 again')
            assert(raisingClient.send(coderiant, 1)[1] == 1, 'Expected the question offered')
            assert(raisingClient.send(coderiant, 2)[1] == 1, 'Expected the right owner')

            assert(sendRaw(2) == 0, 'Expected no second answer')
            raisingClient.finish(coderiant, 0)

            player.assert:hasKI(diligentStory)

            local chick = walks.lostChick(player:getCharVar(walks.lostChickVar))
            assert(chick.solved and chick.result == results.RETURNED, 'Expected the chick returned')
        end)

        it('resets on a wrong owner and Hantileon reports the chick returned to him', function()
            player:setCharVar(walks.lostChickVar, chickValue(6, 3))

            local corua = raisingClient.forNPC(player, 'Corua', 849)
            assert(raisingClient.talk(corua).eventId == 849, 'Expected event 849')

            local answer = raisingClient.send(corua, 1)
            raisingClient.finish(corua, 1)

            assert(answer[0] == 0 and answer[1] == 0, 'Expected the mistaken branch')
            player.assert.no:hasKI(diligentStory)

            local chick = walks.lostChick(player:getCharVar(walks.lostChickVar))
            assert(chick.owner == 0 and chick.result == results.WRONG_OWNER and not chick.solved, 'Expected a reset')

            local hantileon = raisingClient.forNPC(player, 'Hantileon', 852)
            local report    = raisingClient.talk(hantileon)
            assert(report.eventId == 852 and report.params[0] == 1 and report.params[1] == 0, 'Expected 852 with the taken-back line')
            raisingClient.finish(hantileon, 0)

            stubRolls({ 100, 2 })
            assert(careAction(shortWalkOption)[2] == walkEvent.LOST_CHICK, 'Expected the quest re-armed')
        end)

        it('meets Dietmund once on a long walk after Save My Son', function()
            raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADULT_1 })

            stubRolls({ 1, 3 })
            assert(careAction(longWalkOption)[5] == trainer.BRUTUS, 'Expected no Dietmund before Save My Son')

            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)

            stubRolls({ 1, 3 })
            local reply = careAction(longWalkOption)
            assert(reply[0] == 300 and reply[2] == 0 and reply[3] == 0 and reply[5] == trainer.DIETMUND and reply[6] == 0, 'Expected [300, _, 0, 0, _, 6, 0, _]')
            assert(xi.chocoboRaising.hasUserFlag(player, xi.chocoboRaising.userFlag.MET_DIETMUND), 'Expected the met flag')

            stubRolls({ 1, 3 })
            assert(careAction(longWalkOption)[5] == trainer.BRUTUS, 'Expected Dietmund only once')
        end)
    end)
end)
