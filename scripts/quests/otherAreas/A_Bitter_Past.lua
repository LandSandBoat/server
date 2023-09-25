-----------------------------------
-- A Bitter Past
-----------------------------------
-- Log ID: 4, Quest ID: 66
-- Frescheque : !pos 18 -36 12
-- Raminey    : !pos 82 -35 50
-- Equette    : !pos 3 -22 -17
-- ???        : !pos 58 -7 27
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_BITTER_PAST)

quest.reward =
{
    item = xi.items.YINYANG_LORGNETTE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Frescheque'] = quest:progressEvent(151),

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
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
            ['Frescheque'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TINY_WRISTLET) then
                        return quest:progressEvent(154)
                    end
                end,
            },
            ['Raminey'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(152)
                    end
                end,
            },
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(153)
                    end
                end,
            },

            onEventFinish =
            {
                [152] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [153] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [154] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TINY_WRISTLET)
                    end
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            ['qm_bitter_past'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 and npcUtil.popFromQM(player, npc, ID.mob.BITTER_PAST_MOBS, { claim = true, hide = 0 }) then
                        return quest:message(ID.text.SENSE_OF_FOREBODING)

                    elseif not player:hasKeyItem(xi.ki.TINY_WRISTLET) then
                        player:addKeyItem(xi.ki.TINY_WRISTLET)
                        return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TINY_WRISTLET)
                    end
                end,
            },

            ['Splinterspine_Grukjuk'] =
            {
                onMobDeath = function(mob, player)
                    if quest:getVar(player, 'Prog') == 2 then
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
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(155)
                    end
                end,
            },

            ['Frescheque'] = quest:event(157):replaceDefault(),

            onEventFinish =
            {
                [155] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
}

return quest
