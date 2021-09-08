-----------------------------------
-- Glyph Hanger
-----------------------------------
-- !addquest 2 30
-- Hariga-Origa : !pos -62 -6 105 238
-- Ipupu        : !pos 251.745 -5.5 35.539 115
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER)

quest.reward =
{
    exp = 2000,
    fame = 120,
    keyItem = xi.ki.MAP_OF_THE_HORUTOTO_RUINS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Hariga-Origa'] = quest:progressEvent(381),

            onEventFinish =
            {
                [381] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.NOTES_FROM_HARIGAORIGA)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Hariga-Origa'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.NOTES_FROM_IPUPU) then
                        return quest:progressEvent(385)
                    else
                        return quest:event(382)
                    end
                end,
            },

            onEventFinish =
            {
                [385] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.NOTES_FROM_IPUPU)

                        -- Player must zone before being able to flag the next quest
                        player:setLocalVar('Quest[2][20]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            ['Ipupu'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.NOTES_FROM_HARIGAORIGA) then
                        return quest:progressEvent(47, 0, xi.ki.NOTES_FROM_HARIGAORIGA)
                    end
                end,
            },

            onEventFinish =
            {
                [47] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.NOTES_FROM_HARIGAORIGA)
                    npcUtil.giveKeyItem(player, xi.ki.NOTES_FROM_IPUPU)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Hariga-Origa'] = quest:event(386):replaceDefault()
        },
    },
}

return quest
