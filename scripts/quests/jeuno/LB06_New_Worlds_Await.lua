-----------------------------------
-- New Worlds Await
-----------------------------------
-- Log ID: 3, Quest ID: 133
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT)

quest.reward =
{
    fame     = 50,
    fameArea = xi.fameArea.JEUNO,
}

-- Event 10045 is the global event used in all Limit break quest from 6 to 10.
-- Parameter 1 -> player level.
-- Parameter 2 -> player has the Limit Breaker KI (1) or not (2)
-- Parameter 3 -> "ID/number" of current LB quest associated with this npc. LB-6 = 1, LB-7 = 2, LB-8 = 3...
-- Parameter 4 -> progress in current quest.

quest.sections =
{
    -- Section: Quest accepted. There is no quest pre-requisite.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getLevelCap() == 75
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
                        xi.settings.main.MAX_LEVEL > 75 and -- Can we level over 75?
                        playerLevel == 75 and               -- Are we at limit level?
                        limitBreaker == 1                   -- Do we have limit breaker KI? (Pre-requisite)
                    then
                        lastQuestNumber = 1
                    end

                    return quest:progressEvent(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage)
                end,
            },

            onEventUpdate =
            {
                [10045] = function(player, csid, option, npc)
                    if option == 4 then
                        player:updateEvent(243, 2, 3, 1, 17154, 0, 235339776, 4) -- I've taken 3 different captures and they always seem different.
                    end
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    -- Obtain Limit Breaker KI option.
                    if option == 4 then
                        npcUtil.giveKeyItem(player, xi.ki.LIMIT_BREAKER)

                    -- Accept LB6 quest option.
                    elseif option == 5 then
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
                        npcUtil.tradeHasExactly(trade, { { xi.item.KINDREDS_SEAL, 5 } }) and
                        player:getMeritCount() > 2
                    then
                        return quest:progressEvent(10135)
                    end
                end,

                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 1
                    local lastQuestStage  = 1

                    return quest:event(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage) -- Reminder.
                end,
            },

            onEventFinish =
            {
                [10135] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:setMerits(player:getMeritCount() - 3)
                        player:setLevelCap(80)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_80)
                    end
                end,
            },
        },
    },
}

return quest
