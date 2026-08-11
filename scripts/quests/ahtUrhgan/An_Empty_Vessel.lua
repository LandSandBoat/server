-----------------------------------
-- An Empty Vessel (BLU Unlock)
-----------------------------------
-- Log ID: 6, Quest ID: 5
-- Waoud : !pos 65 -6 -78 50
-----------------------------------
-- Every wait on Waoud needs a Vana'diel day change and a zone, in either order.
-- Event 69 does not spend the day's divination.
-- Refusing Yasfel deletes the quest. Accepting and refusing warp the player to different spots.
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)

quest.reward =
{
    title = xi.title.BEARER_OF_THE_MARK_OF_ZAHAK,
}

local requiredItemList =
{
    xi.item.SIRENS_TEAR,
    xi.item.PINCH_OF_VALKURM_SUNSAND,
    xi.item.DANGRUF_STONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
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
                            local requiredItem = math.randomInt(1, 3)

                            quest:setVar(player, 'Option', requiredItem)
                            player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, requiredItem, 70)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'numCorrect', 0)

                    if option == 50 then
                        quest:begin(player)
                        quest:setMustZone(player)
                        quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)

                    -- Divination completed without an offer.
                    elseif
                        option == 45 and
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
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrade = function(player, npc, trade)
                    local requiredItem = quest:getVar(player, 'Option')

                    -- The item is not taken. Yasfel asks for it again in Aydeewa.
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeMatches(trade, { { requiredItemList[requiredItem], 1 } })
                    then
                        return quest:progressEvent(67, { [6] = requiredItem })
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        if questProgress == 0 then
                            return quest:progressEvent(65)
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

            onEventFinish =
            {
                -- Event 65 has no menu. The hint follows on the next conversation.
                [65] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

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

                            -- quest:complete() wipes quest vars.
                            quest:setVar(player, 'completeEvent', 1)
                        end

                        player:setPos(148, -2, 0, 128, xi.zone.AHT_URHGAN_WHITEGATE)

                    -- Player refused Yasfel.
                    elseif option == 7 then
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Timer', 0)
                        quest:setVar(player, 'Option', 0)

                        player:delQuest(quest.areaId, quest.questId)
                        player:setPos(-17.5, -6, 39.6, 171, xi.zone.AHT_URHGAN_WHITEGATE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'completeEvent') == 1 then
                        return quest:progressEvent(69)
                    elseif
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
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
                        player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, math.randomInt(1, 5) * 10)
                    end
                end,
            },

            onEventFinish =
            {
                [69] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'completeEvent', 0)
                    end
                end,

                [78] = function(player, csid, option, npc)
                    if option == 1 and player:getGil() >= 1000 then
                        quest:setMustZone(player)
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
