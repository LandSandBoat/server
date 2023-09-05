-----------------------------------
-- Painful Memory
-----------------------------------
-- Log ID: 3, Quest ID: 63
-- Mertaire: !gotoid 17780764
-- Waters_of_Oblivion: !gotoid 17457346
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)

quest.reward =
{
    item  = xi.items.PAPER_KNIFE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD) == QUEST_COMPLETED and
            player:getMainJob() == xi.job.BRD
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    if  quest:getVar(player, 'initialCS') == 0 then
                        return quest:progressEvent(138)
                    elseif quest:getVar(player, 'initialCS') == 1 then
                        return quest:progressEvent(137)
                    end
                end,
            },

            onEventFinish =
            {
                [138] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'initialCS', 0)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    else
                        quest:setVar(player, 'initialCS', 1)
                    end
                end,

                [137] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'initialCS ', 0)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(136)
                end,
            },

            ['Mataligeat'] =
            {
                onTrigger = function(player, npc)
                    if  quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(141)
                    end
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Waters_of_Oblivion'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) and
                        npcUtil.popFromQM(player, npc, ID.mob.TROS, { claim = true, hide = 0 }) and
                        quest:getVar(player, 'nmKilled') == 0
                    then
                        return quest:messageSpecial(ID.text.SENSE_OF_FOREBODING)
                    elseif
                        quest:getVar(player, 'nmKilled') == 1
                    then
                        return quest:progressEvent(8)
                    end
                end,
            },

            ['Tros'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MERTAIRES_BRACELET)
                    end
                end,
            },
        },
    },
}

return quest
