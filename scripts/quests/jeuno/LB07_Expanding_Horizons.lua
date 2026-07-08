-----------------------------------
-- Expanding Horizons
-----------------------------------
-- Log ID: 3, Quest ID: 134
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS)

quest.reward =
{
    fame     = 50,
    fameArea = xi.fameArea.JEUNO,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT) and
                player:getLevelCap() == 80
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 0
                    local lastQuestStage  = 0
                    if
                        xi.settings.main.MAX_LEVEL > 80 and
                        limitBreaker == 1
                    then
                        if playerLevel > 75 then
                            lastQuestNumber = 2
                        elseif playerLevel == 75 then
                            lastQuestNumber = 1
                            lastQuestStage  = 2
                        end
                    end

                    return quest:progressEvent(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage)
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 7 then -- Accept quest option.
                        quest:begin(player)
                    end
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
                        npcUtil.tradeHasExactly(trade, { { xi.item.KINDREDS_CREST, 5 } }) and
                        player:getMeritCount() > 3
                    then
                        return quest:progressEvent(10136)
                    end
                end,

                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 2
                    local lastQuestStage  = 1

                    return quest:event(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage)
                end,
            },

            onEventFinish =
            {
                [10136] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:setMerits(player:getMeritCount() - 4)
                        player:setLevelCap(85)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_85)
                    end
                end,
            },
        },
    },
}

return quest
