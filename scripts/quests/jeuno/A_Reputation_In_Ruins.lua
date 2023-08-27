-----------------------------------
-- A Reputation In Ruins
-----------------------------------
-- Log ID: 3, Quest ID: 73
-- Migliorozz    !pos -37.76 -1.5 12.9 244
-----------------------------------
require('scripts/globals/quests')
require("scripts/globals/missions")
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_REPUTATION_IN_RUINS)

quest.reward =
{
    gil = 3500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_ROAD_FORKS
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Migliorozz'] =
            {
                onTrigger = function(player, npc)
                    local chance = math.random(1, 2)
                    if chance == 1 then
                        quest:setVar(player, 'KIChoice', xi.keyItem.PHOENIX_ARMLET)
                    else
                        quest:setVar(player, 'KIChoice', xi.keyItem.PHOENIX_PEARL)
                    end
                    return quest:progressEvent(10019, 0, quest:getVar(player, 'KIChoice'))
                end,
            },

            onEventFinish =
            {
                [10019] = function(player, csid, option, npc)
                    if option == 3 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, quest:getVar(player, 'KIChoice'))
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PSOXJA] =
        {
            ['qm_blue_bracelet'] =
            {
                onTrigger = function(player, npc)
                    if GetNPCByID(ID.npc.BLUE_BRACELET_DOOR):getAnimation() == 8 and not player:hasKeyItem(xi.keyItem.BLUE_BRACELET) and player:getLocalVar("blueKilled") == 0 then
                        if GetMobByID(ID.mob.BLUE_GARGOYLES):isSpawned() or GetMobByID(ID.mob.BLUE_GARGOYLES + 1):isSpawned() then
                            return
                        end
                        GetNPCByID(ID.npc.BLUE_BRACELET_DOOR):setAnimation(9)
                        SpawnMob(ID.mob.BLUE_GARGOYLES):updateEnmity(player)
                        SpawnMob(ID.mob.BLUE_GARGOYLES + 1):updateEnmity(player)
                        player:messageName(ID.text.TRAP_ACTIVATED, player)
                        return quest:noAction()
                    elseif player:getLocalVar("blueKilled") == 1 and not player:hasKeyItem(xi.keyItem.BLUE_BRACELET) then
                        player:addKeyItem(xi.keyItem.BLUE_BRACELET)
                        return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BLUE_BRACELET)
                    elseif GetNPCByID(ID.npc.BLUE_BRACELET_DOOR):getAnimation() == 9 then
                        return quest:messageSpecial(ID.text.TIGHTLY_LOCKED)
                    end
                end,
            },

            ['qm_green_bracelet'] =
            {
                onTrigger = function(player, npc)
                    if GetNPCByID(ID.npc.GREEN_BRACELET_DOOR):getAnimation() == 8 and not player:hasKeyItem(xi.keyItem.GREEN_BRACELET) and player:getLocalVar("greenKilled") == 0 then
                        if GetMobByID(ID.mob.GREEN_GARGOYLES):isSpawned() or GetMobByID(ID.mob.GREEN_GARGOYLES + 1):isSpawned() then
                            return
                        end
                        GetNPCByID(ID.npc.GREEN_BRACELET_DOOR):setAnimation(9)
                        SpawnMob(ID.mob.GREEN_GARGOYLES):updateEnmity(player)
                        SpawnMob(ID.mob.GREEN_GARGOYLES + 1):updateEnmity(player)
                        player:messageName(ID.text.TRAP_ACTIVATED, player)
                        return quest:noAction()
                    elseif player:getLocalVar("greenKilled") == 1 and not player:hasKeyItem(xi.keyItem.GREEN_BRACELET) then
                        player:addKeyItem(xi.keyItem.GREEN_BRACELET)
                        return quest:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.GREEN_BRACELET)
                    elseif GetNPCByID(ID.npc.GREEN_BRACELET_DOOR):getAnimation() == 9 then
                        return quest:messageSpecial(ID.text.TIGHTLY_LOCKED)
                    end
                end,
            },

            ['_i95'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(quest:getVar(player, 'KIChoice')) and quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(7, 0, quest:getVar(player, 'KIChoice'))
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:delKeyItem(quest:getVar(player, 'KIChoice'))
                    return quest:messageSpecial(ID.text.PHOENIX_FADES, 0, quest:getVar(player, 'KIChoice'))
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Migliorozz'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10020)
                    end
                end,
            },

            onEventFinish =
            {
                [10020] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    }
}

return quest
