-----------------------------------
-- Lovers in the Dusk
-----------------------------------
-- Log ID: 1, Quest ID: 63
-- Carmelo : !pos -146.476 -7.48 -10.889 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.SIREN_FLUTE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 6 and
                not quest:getMustZone(player)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] = quest:progressEvent(275),

            onEventFinish =
            {
                [275] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CHANSON_DE_LIBERTE)
                    quest:begin(player)
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
            ['Carmelo'] = quest:event(276),
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if VanadielTOTD() == xi.time.DUSK then
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
