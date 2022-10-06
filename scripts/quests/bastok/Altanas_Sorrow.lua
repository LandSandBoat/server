-----------------------------------
-- Altana's Sorrow
-----------------------------------
-- Log ID: 1, Quest ID: 49
-- Virnage : !pos 0 0 51 234
-- qm1     : !pos -282.339 0.001 261.707 200
-- Eperdur : !pos 129 -6 96 231
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.ALTANAS_SORROW)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.SCROLL_OF_TELEPORT_DEM,
    title    = xi.title.PILGRIM_TO_DEM,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 10 and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 4
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Virnage'] = quest:progressEvent(141),

            onEventFinish =
            {
                [141] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Virnage'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.BUCKET_OF_DIVINE_PAINT) then
                        player:startEvent(143)
                    elseif player:hasKeyItem(xi.ki.LETTER_FROM_VIRNAGE) then
                        player:startEvent(144)
                    else
                        player:startEvent(142)
                    end
                end,
            },

            onEventFinish =
            {
                [143] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.BUCKET_OF_DIVINE_PAINT)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_VIRNAGE)
                end,
            },
        },

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.BUCKET_OF_DIVINE_PAINT) and
                        not player:hasKeyItem(xi.ki.LETTER_FROM_VIRNAGE)
                    then
                        return quest:keyItem(xi.ki.BUCKET_OF_DIVINE_PAINT)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LETTER_FROM_VIRNAGE) then
                        return quest:progressEvent(679)
                    end
                end,
            },

            onEventFinish =
            {
                [679] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.LETTER_FROM_VIRNAGE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Virnage'] = quest:event(145):replaceDefault(),
        },
    },
}

return quest
