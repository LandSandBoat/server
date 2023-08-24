-----------------------------------
-- Mihgo's Amigo
-----------------------------------
-- !addquest 2 25
-- Nanaa Mihgo: !pos 62   -4    240    241
-- Ardea      : !pos -198 -6   -69     235
-- Varun      : !pos 7.8  -3.5 -10.064 241
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)

local gilPerTrade = 200

quest.reward =
{
    fame = 16, -- Baesd on 212 yag necklaces needed to reach level 4 tenshodo fame.
    fameArea = xi.quest.fame_area.NORG,
    title = xi.title.CAT_BURGLAR_GROUPIE,
}

quest.sections =
{
    {
        -- QUEST AVAILABLE
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.NORG) >= 1 and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) ~= QUEST_ACCEPTED and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) ~= QUEST_ACCEPTED and
                not player:hasItem(xi.items.MARAUDERS_KNIFE)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == QUEST_ACCEPTED then
                        return quest:progressEvent(81)
                    else
                        return quest:progressEvent(80)
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,

                [81] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,
            },
        },
    },

    {
        -- QUEST ACCEPTED
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(82)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(88, { [0] = gilPerTrade })
                    end
                end,
            },

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(gilPerTrade)
                    quest:complete(player)
                    xi.quest.setMustZone(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
                end,
            },
        },
    },

    -- QUEST COMPLETE
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER) < QUEST_ACCEPTED then
                        return quest:event(89):replaceDefault()
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(494, { [0] = gilPerTrade })
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(gilPerTrade)
                    player:addFame(xi.quest.fame_area.NORG, 16)
                end,
            },
        },
    },
}

return quest
