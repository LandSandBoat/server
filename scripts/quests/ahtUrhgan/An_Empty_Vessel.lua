-----------------------------------
-- An Empty Vessel
-----------------------------------
-- Log ID: 6, Quest ID: 5
-- Waoud : !pos 65 -6 -78 50
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
local whitegateID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)

quest.reward =
{
    title = xi.title.BEARER_OF_THE_MARK_OF_ZAHAK,
}

local requiredItemList =
{
    xi.items.SIRENS_TEAR,
    xi.items.PINCH_OF_VALKURM_SUNSAND,
    xi.items.DANGRUF_STONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local lastDivination = quest:getVar(player, 'Timer')

                    if lastDivination <= VanadielUniqueDay() then
                        return quest:progressEvent(60, player:getGil())
                    else
                        return quest:event(63)
                    end
                end,
            },

            onEventUpdate =
            {
                [60] = function(player, csid, option, npc)
                    local numCorrect = quest:getLocalVar(player, 'numCorrect')

                    -- Search Correct Option list for provided option, and update answers.
                    if option < 40 then
                        local correctOptions = { 2, 6, 9, 12, 13, 18, 21, 24, 26, 30 }

                        for _, correctOption in ipairs(correctOptions) do
                            if option == correctOption then
                                quest:setLocalVar(player, 'numCorrect', numCorrect + 1)
                                break
                            end
                        end

                    -- Display test results.
                    elseif option == 40 then
                        local successParams = { 10, 20, 30, 40, 60 } -- Spring, Stone, Gale, Flame, Sky

                        if numCorrect < 10 then
                            player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, successParams[math.floor(numCorrect / 2) + 1])
                        else
                            local requiredItem = math.random(1, 3)

                            quest:setVar(player, 'Option', requiredItem)
                            player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, requiredItem, 70)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    if option == 50 then
                        quest:begin(player)
                        quest:setMustZone(player)
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    elseif
                        option == 1 and
                        player:getGil() >= 1000
                    then
                        quest:setMustZone(player)
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)

                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrade = function(player, npc, trade)
                    local requiredItem = quest:getVar(player, 'Option')

                    if
                        npcUtil.tradeHasExactly(trade, requiredItemList[requiredItem]) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(67, requiredItemList[requiredItem])
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        if questProgress == 0 then
                            return quest:progressEvent(65, { [6] = quest:getVar(player, 'Option') })
                        elseif questProgress == 1 then
                            return quest:event(66, { [6] = quest:getVar(player, 'Option') })
                        elseif questProgress == 2 then
                            return quest:event(68)
                        end
                    else
                        return quest:event(64)
                    end
                end,
            },

            onEventUpdate =
            {
                [65] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [67] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    local requiredItemID = requiredItemList[quest:getVar(player, 'Option')]

                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasItem(requiredItemID)
                    then
                        return quest:progressEvent(3, requiredItemID)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if option == 13 then
                        if quest:complete(player) then
                            -- Note: Messages for receiving the below items are handled by the event.
                            player:unlockJob(xi.job.BLU)
                            player:addKeyItem(xi.ki.MARK_OF_ZAHAK)
                            player:addKeyItem(xi.ki.JOB_GESTURE_BLUE_MAGE)

                            quest:setVar(player, 'completeEvent', 1)
                        end
                    else
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Timer', 0)
                        quest:setVar(player, 'Option', 0)

                        player:delQuest(quest.areaId, quest.questId)
                    end

                    player:setPos(148, -2, 0, 130, 50)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'completeEvent') == 1 then
                        return quest:progressEvent(69)
                    elseif quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                        -- The timer for Divinations is reused throughout more quests, and continues to persist
                        -- for Blue Mages when talking to Waoud (once per day).  Use this Timer to track throughout
                        -- the remaining series.

                        return quest:event(78, player:getGil())
                    else
                        return quest:event(63)
                    end
                end,
            },

            onEventUpdate =
            {
                [78] = function(player, csid, option, npc)
                    if option == 40 then
                        player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, math.random(1, 5) * 10)
                    end
                end,
            },

            onEventFinish =
            {
                [69] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'completeEvent', 0)

                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)
                    end
                end,

                [78] = function(player, csid, option, npc)
                    if option == 1 and player:getGil() >= 1000 then
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)

                        player:delGil(1000)
                        player:messageSpecial(whitegateID.text.PAY_DIVINATION)
                    end
                end,
            },
        },
    },
}

return quest
