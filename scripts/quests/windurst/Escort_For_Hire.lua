-----------------------------------
-- Escort for Hire (Windurst)
-----------------------------------
-- This quest doesn't function as of now.
-- TODO: Wanzo-Unzozo (The mob/npc to be escorted must) must agro mobs.
-- !addquest 2 88
-- Dehn Harzhapan !pos -7, -6, 152
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
ID = require('scripts/zones/Garlaige_Citadel/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)

quest.reward =
{
    gil = 10000,
    fame = 100,
    fameArea = xi.quest.fame_area.WINDURST,
    item = xi.items.MIRATETES_MEMOIRS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.windurst.ESCORT_FOR_HIRE) ~= QUEST_ACCEPTED and
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.windurst.ESCORT_FOR_HIRE) ~= QUEST_ACCEPTED and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 6 and
            player:getCharVar("ESCORT_CONQUEST") < getConquestTally() and false -- Disables the quest
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Dehn_Harzhapan'] = quest:progressEvent(10014),

            onEventFinish =
            {
                [10014] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.GARLAIGE_CITADEL] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- If a party is already running quest, do not start event.
                    if not GetMobByID(17596834):isSpawned() then
                        if quest:getVar(player, 'Prog') == 0 then
                            for _, v in ipairs(player:getParty()) do
                                quest:setVar(v, 'Prog', 1)
                            end
                            return 60

                        -- Players are trying to redo escort
                        elseif quest:getVar(player, 'Prog') == 2 and not GetMobByID(17596834):isSpawned() then
                            for _, v in ipairs(player:getParty()) do
                                quest:setVar(v, 'Prog', 1)
                            end
                            return 60
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    SpawnMob(17596834)
                    player:getZone():setLocalVar("timer", os.time() + 1800)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Dehn_Harzhapan'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                        return quest:progressEvent(10016)
                    else
                        return quest:progressEvent(10015)
                    end
                end,
            },

            onEventFinish =
            {
                [10016] = function(player, csid, option, npc)
                    player:setCharVar("ESCORT_CONQUEST", getConquestTally())
                    player:delKeyItem(xi.ki.COMPLETION_CERTIFICATE)
                    quest:complete(player)
                end,
                [10015] = function(player, csid, option, npc)
                    if option == 0 then
                        player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
            player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.windurst.ESCORT_FOR_HIRE) ~= QUEST_ACCEPTED and
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.windurst.ESCORT_FOR_HIRE) ~= QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Dehn_Harzhapan'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("ESCORT_CONQUEST") < getConquestTally() then
                        return quest:progressEvent(10014)
                    elseif player:getCharVar("ESCORT_CONQUEST") > getConquestTally() then
                        return quest:progressEvent(10017)
                    end
                end,
            },

            onEventFinish =
            {
                [10014] = function(player, csid, option, npc)
                    player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ESCORT_FOR_HIRE)
                    quest:begin(player)
                end,
            },
        },
    },
}

return quest
