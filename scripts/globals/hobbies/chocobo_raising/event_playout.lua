-----------------------------------
-- Chocobo Raising
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

xi.chocoboRaising.startCutscene = function(player, npc, trade)
    local ID            = zones[player:getZoneID()]
    local reminderCsid  = xi.chocoboRaising.csidTable[player:getZoneID()][1]
    local mainCsid      = xi.chocoboRaising.csidTable[player:getZoneID()][2]
    local tradeCsid     = xi.chocoboRaising.csidTable[player:getZoneID()][3]
    local rejectionCsid = xi.chocoboRaising.csidTable[player:getZoneID()][4]
    local chocoState    = xi.chocoboRaising.initChocoState(player)

    if trade then -- Trade
        if
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_FAINTLY_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SLIGHTLY_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_BIT_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_LITTLE_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
        then
            if chocoState == nil then
                -- Handed over egg, handled in onEventFinish and xi.chocoboRaising.newChocobo
                player:startEvent(tradeCsid, 0, 0, 0, 0, 0, 0, 0, 1)
            else -- Already has a chocobo
                -- Check location
                if chocoState.location ~= xi.chocoboRaising.raisingLocation[player:getZoneID()] then
                    player:startEvent(rejectionCsid, 1)
                else
                    player:startEvent(rejectionCsid, 0)
                end
            end

            return
        end

        -- TODO: Confirm this on retail
        -- 'Your chocobo has not hatched, so you cannot feed it yet.'
        if chocoState.stage == xi.chocoboRaising.stage.EGG then
            player:messageSpecial(ID.text.CHOCOBO_FEEDING_STILL_EGG)
            return
        end

        -- Validate traded items
        local tradedItems = {}

        for slotId = 0, 7 do
            local item = trade:getItem(slotId)

            if item then
                local id = item:getID()
                -- Invalid foods are skipped and valid foods are accepted
                if xi.chocoboRaising.validFoods[id] then
                    local quantity = trade:getSlotQty(slotId)

                    for _ = 1, quantity do
                        table.insert(tradedItems, id)
                    end

                    trade:confirmItem(id, quantity)
                end
            end
        end

        if #tradedItems > 0 then
            chocoState.foodGiven = tradedItems
        end
    else -- Trigger
        -- Trade an egg to me if you want to start raising a chocobo.
        if chocoState == nil then
            player:startEvent(reminderCsid, 1)
            return
        else
            -- Check location
            if chocoState.location ~= xi.chocoboRaising.raisingLocation[player:getZoneID()] then
                player:startEvent(reminderCsid, 1, 1, 1, 1)

                return
            end
        end
    end

    local isTradeEvent = 0

    if #chocoState.foodGiven > 0 then
        isTradeEvent = 8
    end

    -- 0: Hello, x. What brings you here today?
    -- 1: Hello, x. I have some information to relay to you regarding your egg.
    local infoFlag = 0

    if #chocoState.report.events > 0 then
        infoFlag = 1
    end

    -- Now that we're done modifiying it, write chocoState to cache
    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    player:startEventString(mainCsid, chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
        isTradeEvent, infoFlag, chocoState.sex, 0, 0, 0, 0, 0)
end

xi.chocoboRaising.handleCSUpdate = function(player, chocoState, doEventUpdate)
    -- Generate final CS value from (location offset * 256) + cutscene offset
    local csOffset       = chocoState.csList[1]
    local locationOffset = xi.chocoboRaising.raisingLocation[player:getZoneID()] * 256
    local csToPlay       = locationOffset + csOffset

    debug('Playing CS: ' .. csToPlay .. ' (' .. csOffset .. ')')
    table.remove(chocoState.csList, 1)

    local currentAgeOfChocoboDuringCutscene = 0

    -- TODO: Move this into initData
    if csOffset == xi.chocoboRaising.cutscenes.EGG_HATCHING then
        chocoState.stage = xi.chocoboRaising.stage.CHICK
    elseif csOffset == xi.chocoboRaising.cutscenes.CHICK_TO_ADOLESCENT then
        chocoState.stage = xi.chocoboRaising.stage.ADOLESCENT
    elseif csOffset == xi.chocoboRaising.cutscenes.ADOLESCENT_TO_ADULT_1 then
        chocoState.stage = xi.chocoboRaising.stage.ADULT_1
    elseif csOffset == xi.chocoboRaising.cutscenes.ADULT_1_TO_ADULT_2 then
        chocoState.stage = xi.chocoboRaising.stage.ADULT_2
    elseif csOffset == xi.chocoboRaising.cutscenes.ADULT_2_TO_ADULT_3 then
        chocoState.stage = xi.chocoboRaising.stage.ADULT_3
    elseif csOffset == xi.chocoboRaising.cutscenes.ADULT_3_TO_ADULT_4 then
        chocoState.stage = xi.chocoboRaising.stage.ADULT_4
    end

    chocoState = xi.chocoboRaising.onRaisingEventPlayout(player, csOffset, chocoState)

    -- Skip the event updates during 'Skip Report'
    if doEventUpdate then
        player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.first_name,
            0, 0, 0, 0, 0, 0, 0, 0)
        player:updateEvent(#chocoState.csList, csToPlay, 0, chocoState.color, chocoState.stage, 0, currentAgeOfChocoboDuringCutscene, 1)
    end

    return chocoState
end

xi.chocoboRaising.onRaisingEventPlayout = function(player, csOffset, chocoState)
    switch (csOffset): caseof
    {
        -- EGG ONWARDS:
        [xi.chocoboRaising.cutscenes.REPORT_BASIC_CARE] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.BASIC_CARE)
        end,

        -- CHICK ONWARDS:
        [xi.chocoboRaising.cutscenes.REPORT_REST] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.RESTING)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_TAKE_A_WALK] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.TAKING_A_WALK)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_LISTEN_TO_MUSIC] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.LISTENING_TO_MUSIC)
        end,

        -- ADOLESCENT ONWARDS:
        [xi.chocoboRaising.cutscenes.REPORT_EXERCISE_ALONE] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.EXERCISING_ALONE)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_EXERCISE_IN_A_GROUP] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.EXCERCISING_IN_A_GROUP)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_INTERACT_WITH_CHILDREN] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.PLAYING_WITH_CHILDREN)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_INTERACT_WITH_CHOCOBOS] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.PLAYING_WITH_CHOCOBOS)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_CARRY_PACKAGES] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.CARRYING_PACKAGES)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_EXHIBIT_TO_THE_PUBLIC] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.EXHIBITING_TO_THE_PUBLIC)
        end,

        -- ADULT ONWARDS:
        [xi.chocoboRaising.cutscenes.REPORT_DELIVER_MESSAGES] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.DELIVERING_MESSAGES)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_DIG_FOR_TREASURE] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.DIGGING_FOR_TREASURE)
        end,

        [xi.chocoboRaising.cutscenes.REPORT_ACT_IN_A_PLAY] = function()
            xi.chocoboRaising.handleCarePlan(player, chocoState, xi.chocoboRaising.carePlans.ACTING_IN_A_PLAY)
        end,

        -- Growth CSs
        [xi.chocoboRaising.cutscenes.ADULT_2_TO_ADULT_3] = function()
            -- You waited too long to name your chocobo, trainer is going to do it for you!
            if
                chocoState.first_name == 'Chocobo' and
                chocoState.last_name == 'Chocobo'
            then
                -- Pick a name at random: First name only
                chocoState.first_name = xi.chocoboNames.getRandomName()
                chocoState.last_name = ''
            end
        end,

        [xi.chocoboRaising.cutscenes.CRYING_AT_NIGHT] = function()
            -- NOTE: The messaging is handled in the CS
            player:addKeyItem(xi.ki.WHITE_HANDKERCHIEF)
            player:setCharVar('[choco]WH_TIME', GetSystemTime() * utils.days(1))
        end,

        [xi.chocoboRaising.cutscenes.HAVENT_SEEN_YOU] = function()
            player:delKeyItem(xi.ki.WHITE_HANDKERCHIEF)
            player:setCharVar('[choco]WH_TIME', 0)
        end,

        [xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME] = function()
            -- TODO: Take in a multiplier to account for merged time ranges
            chocoState.affection = xi.chocoboRaising.handleStatChange(chocoState.affection, -10, 255)
            chocoState.energy    = xi.chocoboRaising.handleStatChange(chocoState.energy, -5, 100)
            xi.chocoboRaising.setCondition(chocoState, xi.chocoboRaising.conditions.SPOILED, false)
        end,

        [xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS] = function()
            -- TODO: Take in a multiplier to account for merged time ranges
            -- 'Increases affection slightly - confirmed.'
            chocoState.affection = xi.chocoboRaising.handleStatChange(chocoState.affection, 1, 255)
            chocoState.energy    = xi.chocoboRaising.handleStatChange(chocoState.energy, -5, 100)
            xi.chocoboRaising.setCondition(chocoState, xi.chocoboRaising.conditions.BORED, false)
        end,
    }

    xi.chocoboRaising.updateChocoState(player, chocoState)

    return chocoState
end
