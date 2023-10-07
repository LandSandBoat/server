-----------------------------------
-- A Craftmans Work
-- !addquest 0 94
-----------------------------------
-- Miaux !gotoid 17723442
-- Easterrn Altepa ??? !gotoid 17244622
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local easternAltepaID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_CRAFTSMAN_S_WORK)

quest.reward =
{
    item     = xi.items.PEREGRINE,
    fame     = 20,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.DRG and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Miaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'csSeen') == 0 then
                        return quest:progressEvent(73)
                    elseif quest:getVar(player, 'csSeen') == 1 then --Declined First Offering.
                        return quest:progressEvent(71)
                    end
                end,
            },

            onEventFinish =
            {
                [73] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'csSeen', 0)
                    else
                        quest:setVar(player, 'csSeen', 1) -- Declined First Offering.
                    end
                end,

                [71] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                        quest:setVar(player, 'csSeen', 0)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Miaux'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ALTEPA_POLISHING_STONE) then
                        return quest:progressEvent(70)
                    else
                        return quest:event(69)
                    end
                end,
            },

        onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ALTEPA_POLISHING_STONE)
                    end
                end,
            },
        },

        [xi.zone.EASTERN_ALTEPA_DESERT] =
        {
            ['qm'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        if npcUtil.popFromQM(player, npc, easternAltepaID.mob.DECURIO_I_III, { claim = true, hide = 0 }) then
                            return quest:messageSpecial(easternAltepaID.text.HOSTILE_GAZE)
                        end
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.ALTEPA_POLISHING_STONE)
                        quest:setVar(player, 'nmKilled', 0)
                        quest:setVar(player, 'Prog', 2)
                        return quest:noAction()
                    end
                end,
            },

            ['Decurio_I-III'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },
    },
}

return quest
