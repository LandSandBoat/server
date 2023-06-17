-----------------------------------
-- The Eleventh's Hour
-----------------------------------
-- Log ID: 1, Quest ID: 7
-- Babenn      : !pos 73 -1 34 234
-- Elki        : !pos -17.087 -0.05 52.745 234
-- Old Toolbox : !pos 113.649 -32.8 79.617 143
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTHS_HOUR)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.SMALL_SWORD,
    title    = xi.title.PURSUER_OF_THE_TRUTH,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3 and
                not quest:getMustZone(player)
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Elki'] = quest:progressEvent(43),

            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    if option == 1 then
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
            ['Babenn'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(45)
                    end
                end,
            },

            ['Elki'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.OLD_TOOLBOX) then
                        return quest:progressEvent(44)
                    end
                end,
            },

            ['Parraggoh'] =
            {
                onTrigger = function(player, npc)
                    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTHS_HOUR) then
                        return quest:event(46)
                    end
                end,
            },

            ['Pavvke'] = quest:event(48),

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [45] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.OLD_TOOLBOX)
                    end
                end,
            },
        },

        [xi.zone.PALBOROUGH_MINES] =
        {
            ['Old_Toolbox'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.OLD_TOOLBOX) then
                        return quest:progressEvent(23)
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.OLD_TOOLBOX)
                    end
                end
            },
        },
    },
}

return quest
