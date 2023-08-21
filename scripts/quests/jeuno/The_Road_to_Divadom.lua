-----------------------------------
-- The Road to Divadom
-----------------------------------
-- !addquest 3 97
-- Laila           : !pos -54.045 -1 100.996 244
-- Rhea Myuliah    : !pos -56.220 -1 101.805 244
-- Glowing Pebbles : !pos 104.2 4.1 443.6 82
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM)

quest.reward =
{
    title = xi.title.STARDUST_DANCER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) and
                player:getMainJob() == xi.job.DNC and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                not quest:getMustZone(player) and
                quest:getVar(player, 'Timer') <= VanadielUniqueDay()
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] = quest:progressEvent(10136),

            onEventFinish =
            {
                [10136] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                player:getMainJob() == xi.job.DNC
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(10137)
                    elseif questProgress == 3 then
                        -- Note: Retail handles this as a progression of onZoneIn events.
                        -- Instead, we queue these here.

                        player:startEvent(10139)
                        player:startEvent(10214)
                        player:startEvent(10215)
                        return quest:progressEvent(10170)
                    elseif questProgress == 4 then
                        return quest:progressEvent(10170)
                    end
                end,
            },

            ['Rhea_Myuliah'] = quest:event(10138),

            onEventFinish =
            {
                [10170] = function(player, csid, option, npc)
                    local tightsItemID = xi.item.DANCERS_TIGHTS_F - player:getGender()

                    if npcUtil.giveItem(player, tightsItemID) then
                        quest:complete(player)

                        player:setCharVar('Quest[3][98]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Quest[3][98]mustZone', 1)
                        player:setCharVar('HQuest[DncArtifact]Prog', 1)
                    else
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Glowing_Pebbles'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.BLOCK_OF_YAGUDO_GLUE)
                    then
                        return quest:progressEvent(107)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(106)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 0 then
                        return 105
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [106] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [107] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila']        = quest:event(10140):replaceDefault(),
            ['Rhea_Myuliah'] = quest:event(10141):replaceDefault(),
        },
    },
}

return quest
