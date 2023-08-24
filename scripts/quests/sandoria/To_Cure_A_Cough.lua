-----------------------------------
-- To Cure a Cough
-----------------------------------
-- Log ID  : 0, Quest ID: 20
-- Nenne   : !gotoid 17719324
-- Amaura  : !gotoid 17719327
-- QM1     : !gotoid 17388011
-- Signpost: !gotoid 17191510
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.A_MOSS_KIND_PERSON,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN) and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Nenne'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.THYME_MOSS) and
                        not player:hasKeyItem(xi.ki.COUGH_MEDICINE) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(538)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(584)
                    end
                end,
            },

            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        player:getCharVar("DiaryPage") >= 3
                    then
                        return quest:progressEvent(636)
                    end
                end,
            },

            onEventFinish =
            {
                [538] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [636] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.DAVOI] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.THYME_MOSS) then
                        npcUtil.giveKeyItem(player, xi.ki.THYME_MOSS)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.THYME_MOSS) then
                        return quest:progressEvent(646)
                    elseif not player:hasKeyItem(xi.ki.COUGH_MEDICINE) then
                        return quest:event(645)
                    elseif player:hasKeyItem(xi.ki.COUGH_MEDICINE) then
                        return quest:event(642)
                    end
                end,
            },

            ['Nenne'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.COUGH_MEDICINE) then
                        return quest:progressEvent(647)
                    end
                end,
            },

            onEventFinish =
            {
                [646] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.THYME_MOSS)
                    npcUtil.giveKeyItem(player, xi.ki.COUGH_MEDICINE)
                end,

                [647] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.COUGH_MEDICINE)
                        npcUtil.giveKeyItem(player, xi.ki.SCROLL_OF_TREASURE)
                    end
                end,
            },
        },
    },
}

return quest
