-----------------------------------
-- Unforgiven
-----------------------------------
-- Log ID: 4, Quest ID: 72
-- Elysia :  !pos -50.410 -22.204 -41.640 26
-- Pradiulot !pos -20.814 -22 8.399 26
-- ???       !pos 110.714 -40.856 -53.154 26
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)

quest.reward =
{
    keyItem  = xi.ki.MAP_OF_TAVNAZIA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Elysia'] = quest:progressEvent(200),

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Elysia'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN) then
                        return quest:event(201)
                    elseif
                        player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(202)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(203)
                    end
                end,
            },
            ['Pradiulot'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(204)
                    end
                end,
            },
            ['qm_unforgiven'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN) then
                        npcUtil.giveKeyItem(player, xi.ki.ALABASTER_HAIRPIN)
                        quest:setVar(player, 'Prog', 1)
                        return quest:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [204] = function(player, csid, option, npc)
                    if quest:complete(player) then
                           player:delKeyItem(xi.ki.ALABASTER_HAIRPIN)
                           quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Pradiulot'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(206)
                    end
                end,
            },

        onEventFinish =
            {
            [206] = function(player, csid, option, npc)
                quest:setVar(player, 'Prog', 0)
            end,
            },
        },
    },
}

return quest
