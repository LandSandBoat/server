-----------------------------------
-- An Undying Pledge
-----------------------------------
-- Log ID: 5, Quest ID: 149
-- Stray Cloud : !pos 49 -6 15 252
-- qm5         : !gotoid 17498653
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)

quest.reward =
{
    item = xi.items.LIGHT_BUCKLER,
    fameArea = xi.quest.fame_area.NORG,
    fame = 50,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.NORG) >= 4
        end,

        [xi.zone.NORG] =
        {
            ['Stray_Cloud'] = quest:progressEvent(225),

            onEventFinish =
            {
                [225] = function(player, csid, option, npc)
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Stray_Cloud'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(228)
                    elseif player:hasKeyItem(xi.ki.CALIGINOUS_BLADE) then
                        return quest:progressEvent(227)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(229)
                    end
                end,
            },

            onEventFinish =
            {
                [227] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CALIGINOUS_BLADE)
                    end
                end,
            },
        },

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 and npcUtil.popFromQM(player, npc, ID.mob.GLYRYVILU, { claim = true, hide = 0 }) then
                        return quest:messageSpecial(ID.text.BODY_NUMB_DREAD)
                    elseif
                        quest:getVar(player, 'Prog') == 3
                    then
                        return quest:progressEvent(18)
                    end
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CALIGINOUS_BLADE)
                end,
            },

            ['Glyryvilu'] =
            {
                onMobDeath = function(mob, player, optParams)
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

        [xi.zone.NORG] =
        {
            ['Stray_Cloud'] = quest:event(230):replaceDefault(),
        },
    },
}

return quest
