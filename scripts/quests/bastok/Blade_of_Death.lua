-----------------------------------
-- Blade of Death
-----------------------------------
-- Log ID: 1, Quest ID: 47
-- Gumbah : !pos 52 0 -36 234
-- qm2    : !pos 206 -60 -101 196
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.DEATHBRINGER,
    title    = xi.title.BLACK_DEATH,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Gumbah'] = quest:progressEvent(130),

            onEventFinish =
            {
                [130] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_ZEID)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ZERUHN_MINES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.PALBOROUGH_MINES and
                        not player:hasItem(xi.items.CHAOSBRINGER)
                    then
                        return 131
                    end
                end,
            },

            onEventFinish =
            {
                [131] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.CHAOSBRINGER)
                end,
            },
        },

        [xi.zone.GUSGEN_MINES] =
        {
            ['qm2'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.CHAOSBRINGER) and
                        player:getCharVar("ChaosbringerKills") >= 200
                    then
                        return quest:progressEvent(10)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:delKeyItem(xi.ki.LETTER_FROM_ZEID)
                    end
                end,
            },
        },
    },
}

return quest
