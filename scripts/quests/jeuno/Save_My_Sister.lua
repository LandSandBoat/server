-----------------------------------
-- Save My Sister
-----------------------------------
-- Log ID: 3, Quest ID: 1
-- Baudin        : !pos -75 0 80 244
-- Mailloquetat  : !pos -31 -1 8 244
-- Neraf-Najiruf : !pos -36 2 60 243
-- Brazier (F-9) : !pos 101 -33 -59 195
-- Brazier (H-7) : !pos 259 -33 99 195
-- Brazier (F-7) : !pos 99 -33 98 195
-- Brazier (H-9) : !pos 259 -33 -58 195
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local eldiemeID = require('scripts/zones/The_Eldieme_Necropolis/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SISTER)

quest.reward =
{
    gil   = 3000,
    item  = xi.items.HOLY_MACE,
    title = xi.title.EXORCIST_IN_TRAINING,
}

local brazierMessages =
{
    [0] = { eldiemeID.text.THE_LIGHT_DIMLY,           eldiemeID.text.REFUSE_TO_LIGHT  },
    [1] = { eldiemeID.text.THE_LIGHT_HAS_INTENSIFIED, eldiemeID.text.LANTERN_GOES_OUT },
    [2] = { eldiemeID.text.THE_LIGHT_HAS_INTENSIFIED, eldiemeID.text.LANTERN_GOES_OUT },
    [3] = { eldiemeID.text.THE_LIGHT_IS_FULLY_LIT,    eldiemeID.text.LANTERN_GOES_OUT },
}

-- NOTE: This quest does not appear in the player's quest log until it has been completed.
quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CREST_OF_DAVOI) and
                player:getFameLevel(xi.quest.fame_area.JEUNO) >= 4
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Baudin'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(172)
                    elseif questProgress == 2 then
                        return quest:progressEvent(105)
                    elseif questProgress == 4 then
                        return quest:event(27)
                    elseif questProgress == 5 then
                        return quest:progressEvent(107)
                    end
                end,
            },

            ['Mailloquetat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(159)
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [107] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [159] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [172] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Neraf-Najiruf'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 3 then
                        return quest:progressEvent(98)
                    elseif questProgress == 4 then
                        return quest:progressEvent(99)
                    end
                end,
            },

            onEventFinish =
            {
                [98] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DUCAL_GUARDS_LANTERN)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['Brazier'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(44)
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    if option == 0 then
                        local lanternStage  = quest:getVar(player, 'Stage')
                        local lanternOffset = npc:getID() - eldiemeID.npc.BRAZIER

                        if lanternStage == lanternOffset then
                            player:messageSpecial(brazierMessages[lanternStage][1], 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)

                            if lanternStage < 3 then
                                quest:incrementVar(player, 'Stage', 1)
                            else
                                quest:setVar(player, 'Prog', 5)
                            end
                        else
                            player:messageSpecial(brazierMessages[lanternStage][2], 0, 0, 0, xi.ki.DUCAL_GUARDS_LANTERN_LIT)
                            quest:setVar(player, 'Stage', 0)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Baudin'] = quest:event(176):replaceDefault(),
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Neraf-Najiruf'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.DUCAL_GUARDS_LANTERN) then
                        return quest:progressEvent(97)
                    end
                end,
            },

            onEventFinish =
            {
                [97] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.DUCAL_GUARDS_LANTERN)
                end,
            },
        },
    },
}

return quest
