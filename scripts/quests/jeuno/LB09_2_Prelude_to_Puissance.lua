-----------------------------------
-- Prelude_to_Puissance
-----------------------------------
-- Log ID: 3, Quest ID: 170
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.PRELUDE_TO_PUISSANCE)

-- TODO: Properly code timing minigame. Awaiting for a capture.
-- Amount of visual qeues selected at random. Min: Probably 3. Max: 7. Camera angle keeps changing qithout hints.
-- Always the same camera angle at victory.

quest.reward =
{
    fame = 50,
    fameArea = xi.fameArea.JEUNO,
    keyItem = xi.ki.SOUL_GEM_CLASP,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED) and
                player:getLevelCap() == 95
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    local eventId         = 10045
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 0
                    local lastQuestStage  = 0
                    if
                        xi.settings.main.MAX_LEVEL > 95 and
                        limitBreaker == 1
                    then
                        if playerLevel > 90 then
                            eventId         = 10194
                            lastQuestNumber = 6
                            lastQuestStage  = 2
                        elseif playerLevel >= 75 then
                            lastQuestNumber = 4
                            lastQuestStage  = 2
                        end
                    end

                    return quest:progressEvent(eventId, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage)
                end,
            },

            onEventFinish =
            {
                [10194] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'tradeCompleted') == 0 and
                        npcUtil.tradeHasExactly(trade, xi.item.SEASONING_STONE)
                    then
                        quest:setVar(player, 'tradeCompleted', 1)
                        player:confirmTrade()

                        return quest:progressEvent(10045, 0, 1, 5, 0)
                    end
                end,

                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 6
                    local lastQuestStage  = 2
                    if quest:getVar(player, 'tradeCompleted') > 0 then
                        lastQuestNumber = 5
                        lastQuestStage  = 0
                    end

                    return quest:progressEvent(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage, 0)
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    -- All this options complete the current quest.
                    if
                        option == 0 or
                        option == 13 or
                        option == 14 or
                        option == 15 or
                        option == 19 or
                        option == 20 or
                        option == 21
                    then
                        -- Rejected offer. Still completes quest.
                        if option == 15 then
                            player:setLocalVar('rejectedStartLB10', 1)
                        end

                        -- Complete quest.
                        if quest:complete(player) then
                            -- This options immediately start next quest. (All except 0 and 15).
                            if
                                option ~= 0 and
                                option ~= 15
                            then
                                player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)
                            end

                            -- This options also warp you to a BCNM. Note that the quest "Beyond Infinity" is already activated in this cases.
                            if option == 14 then
                                player:setPos(-511.459, 159.004, -210.543, 10, 139) -- Horlais Peek
                            elseif option == 19 then
                                player:setPos(-349.899, 104.213, -260.150, 0, 144) -- Waughrum Shrine
                            elseif option == 20 then
                                player:setPos(299.316, -123.591, 353.760, 66, 146) -- Balga's Dais
                            elseif option == 21 then
                                player:setPos(-225.146, -24.250, 20.057, 255, 206) -- Qu'bia Arena
                            end
                        end
                    end
                end,
            },
        },
    },
}

return quest
