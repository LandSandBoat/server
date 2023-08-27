-----------------------------------
-- Shadows of the Departed
-----------------------------------
-- !addquest 3 88
-- Ru'Lude Gardens Palace Region 1
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/common')
require("scripts/globals/npc_util")
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local ID = require('scripts/zones/RuLude_Gardens/IDs')
local meaID = require('scripts/zones/Promyvion-Mea/IDs')
local demID = require('scripts/zones/Promyvion-Dem/IDs')
local hollaID = require('scripts/zones/Promyvion-Holla/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) and
            player:getCurrentMission(xi.mission.log_id.ZILART) == xi.mission.id.zilart.AWAKENING and
            player:getMissionStatus(xi.mission.log_id.ZILART) >= 3 and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) == QUEST_AVAILABLE and
            player:getCharVar("StormsOfFateWait") <= os.time()
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, region)
                    return quest:progressEvent(161)
                end,
            },

            onEventFinish =
            {
                [161] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.NOTE_WRITTEN_BY_ESHANTARL)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PROMYVION_DEM] =
        {
            ['_0id'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PROMYVION_DEM_SLIVER) then
                        npcUtil.giveKeyItem(player, xi.ki.PROMYVION_DEM_SLIVER)
                    else
                        return quest:messageSpecial(demID.text.BARRIER_WOVEN)
                    end
                end,
            },

        },

        [xi.zone.PROMYVION_HOLLA] =
        {
            ['_0gc'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER) then
                        npcUtil.giveKeyItem(player, xi.ki.PROMYVION_HOLLA_SLIVER)
                    else
                        return quest:messageSpecial(hollaID.text.BARRIER_WOVEN)
                    end
                end,
            },

        },

        [xi.zone.PROMYVION_MEA] =
        {
            ['_0k0'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PROMYVION_MEA_SLIVER) then
                        npcUtil.giveKeyItem(player, xi.ki.PROMYVION_MEA_SLIVER)
                    else
                        return quest:messageSpecial(meaID.text.BARRIER_WOVEN)
                    end
                end,
            },

        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, region)
                    if
                        player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER) and
                        player:hasKeyItem(xi.ki.PROMYVION_MEA_SLIVER) and
                        player:hasKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
                    then
                        return quest:progressEvent(162)
                    end
                end,
            },

            onEventFinish =
            {
                [162] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER)
                        player:delKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
                        player:delKeyItem(xi.ki.PROMYVION_MEA_SLIVER)
                        player:messageSpecial(ID.text.YOU_HAND_THE_THREE_SLIVERS)
                        xi.quest.setVar(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
                    end
                end,
            },
        },
    }
}

return quest
