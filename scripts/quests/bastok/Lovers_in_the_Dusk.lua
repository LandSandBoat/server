-----------------------------------
-- Lovers in the Dusk
-----------------------------------
-- Log ID: 1, Quest ID: 63
-- Carmelo : !gotoid 17743884
-- QM4 : !gotoid 17273396
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.SIREN_FLUTE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE) and
                not player:needToZone() -- need to zone from previous quest Love and Ice
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] = quest:progressEvent(275),

            onEventFinish =
            {
                [275] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.CHANSON_DE_LIBERTE)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(276)
                    end
                end,
            },

        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        VanadielHour() >= 16 and
                        VanadielHour() <= 18
                        then
                        return quest:progressEvent(204)
                    end
                end,
            },

            onEventFinish =
            {
                [204] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CHANSON_DE_LIBERTE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] = quest:event(277):replaceDefault(),
        },
    },
}

return quest
