-----------------------------------
-- It Sets My Heart Aflutter (It_Sets_My_Heart_Aflutter)
-- Adoulin Fame Quest Cycle 1/3
-- https://ffxiclopedia.fandom.com/wiki/It_Sets_My_Heart_Aflutter
-- https://www.bg-wiki.com/ffxi/It_Sets_My_Heart_Aflutter
-----------------------------------
-- PIONEERS_BADGE : !addkeyitem 2157
-- TWITHERYM_WING : !additem 3930 2
-- Saldinor       : !pos -338.882 -1.000 -308.252 258
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.IT_SETS_MY_HEART_AFLUTTER)

-- NOTE:
-- It is reported that to reach max fame (~610) you must complete this cycle of quests
-- around 30 times, for a total of ~100 quests.
-- 610 / 100 = ~6 fame each
quest.reward =
{
    fame     = 6,
    fameArea = xi.quest.fame_area.ADOULIN,
    xp       = 500,
    bayld    = 200,
}

quest.sections =
{
    -- Section: Begin quest (First time)
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:hasKeyItem(xi.ki.PIONEERS_BADGE)
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Saldinor'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(330)
                end,
            },

            onEventFinish =
            {
                [330] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Begin quest (Repeated)
    {
        check = function(player, status, vars)
            return player:hasCompletedQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.IT_SETS_MY_HEART_AFLUTTER) and
                player:hasCompletedQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_GOOD_PAIR_OF_CROCS) and
                player:hasCompletedQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_SHOT_IN_THE_DARK) and
                player:getCharVar('ADOULIN_FAME_QUEST_TRACKER') == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Saldinor'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(332)
                end,
            },

            onEventFinish =
            {
                [332] = function(player, csid, option, npc)
                    player:delQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.IT_SETS_MY_HEART_AFLUTTER)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Questing
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Saldinor'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(333)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.TWITHERYM_WING, 2 } }) then
                        return quest:progressEvent(331)
                    end
                end,
            },

            onEventFinish =
            {
                [331] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:setCharVar('ADOULIN_FAME_QUEST_TRACKER', 1)
                    end
                end,
            },
        },
    },

    -- Section: Completed quest
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Saldinor'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(329)
                end,
            },
        },
    },
}

return quest
