-----------------------------------
-- A Good Pair of Crocs (A_Good_Pair_of_Crocs)
-- Adoulin Fame Quest Cycle 2/3
-- https://ffxiclopedia.fandom.com/wiki/A_Good_Pair_of_Crocs
-- https://www.bg-wiki.com/ffxi/A_Good_Pair_of_Crocs
-----------------------------------
-- VELKK_NECKLACE : !additem 3928
-- VELKK_MASK     : !additem 3929
-- Felmsy         : !pos -53.111 -0.150 88.456 257
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_GOOD_PAIR_OF_CROCS)

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
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Felmsy'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(3001)
                end,
            },

            onEventFinish =
            {
                [3001] = function(player, csid, option, npc)
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
                player:getCharVar('ADOULIN_FAME_QUEST_TRACKER') == 1
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Felmsy'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(3003)
                end,
            },

            onEventFinish =
            {
                [3003] = function(player, csid, option, npc)
                    player:delQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_GOOD_PAIR_OF_CROCS)
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

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Felmsy'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(3004)
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.VELKK_NECKLACE) or
                        npcUtil.tradeHasExactly(trade, xi.item.VELKK_MASK)
                    then
                        return quest:progressEvent(3002)
                    end
                end,
            },

            onEventFinish =
            {
                [3002] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:setCharVar('ADOULIN_FAME_QUEST_TRACKER', 2)
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

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Felmsy'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(3000)
                end,
            },
        },
    },
}

return quest
