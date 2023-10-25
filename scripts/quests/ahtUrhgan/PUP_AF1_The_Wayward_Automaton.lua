-----------------------------------
-- The Wayward Automaton
-- PUP AF1
-----------------------------------
-- Log ID: 6, Quest ID: 27
-- Iruku-Waraki !pos 101.329 -6.999 -29.042 50
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local mireID = require('scripts/zones/Caedarva_Mire/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)

quest.reward =
{
    item  = xi.items.TURBO_ANIMATOR,
}

quest.sections =
{
    -- Section: Quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.PUP and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =  quest:progressEvent(774),

            onEventFinish =
            {
                [774] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NASHMAU] =
        {
            ['Dnegan'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(289)
                    end
                end,
            },

            onEventFinish =
            {
                [289] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(775)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(776)
                    end
                end,
            },

            onEventFinish =
            {
                [776] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('Quest[6][28]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm9'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:getLocalVar('killed_nm') == 0 and
                        npcUtil.popFromQM(player, npc, mireID.mob.CAEDARVA_TOAD, { hide = 0 })
                    then
                        return quest:messageSpecial(mireID.text.HIDEOUS_BEAST)
                    elseif
                        quest:getVar(player, 'Prog') == 2 and
                        player:getLocalVar('killed_nm') == 1
                    then -- if leave zone before rechecking ??? must fight NM again.
                        return quest:progressEvent(14)
                    end
                end,
            },

            ['Caedarva_Toad'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        player:setLocalVar('killed_nm', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
}

return quest
