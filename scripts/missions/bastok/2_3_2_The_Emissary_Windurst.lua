-----------------------------------
-- The Emissary Windurst
-- Bastok M2-3 (Part 1)
-----------------------------------
-- !addmission 1 7
-- Kupipi    : !pos 2 0.1 30 242
-- Melek     : !pos -80 -5 158 240
-- Uu Zhoumo : !pos -179 16 155 145
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local northSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Uu_Zhoumo'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.ASPIR_KNIFE) then
                        return mission:progressEvent(41)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 4 then -- Reject Sword and request Aspir Knife.
                        return mission:progressEvent(40)
                    elseif missionStatus == 5 then -- Waiting for Aspir Knife.
                        return mission:progressEvent(43)
                    elseif missionStatus >= 6 then -- After trading Aspir Knife.
                        return mission:progressEvent(44)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                end,

                [41] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.DULL_SWORD)
                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 3 then
                        local needsSemihTrust = (not player:hasSpell(940) and not player:hasItem(xi.items.CIPHER_OF_SEMIHS_ALTER_EGO)) and 1 or 0
                        local hasTrustQuest =
                        (
                            player:hasKeyItem(xi.ki.SAN_DORIA_TRUST_PERMIT) or
                            player:hasKeyItem(xi.ki.BASTOK_TRUST_PERMIT) or
                            player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT)
                        ) and 0 or 1

                        return mission:progressEvent(239, 0, 0, 0, xi.nation.BASTOK, 0, hasTrustQuest, needsSemihTrust)
                    elseif missionStatus == 5 then
                        return mission:event(240)
                    elseif missionStatus == 6 then
                        return mission:event(241)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return 42
                    end
                end,
            },

            onEventUpdate =
            {
                [42] = function(player, csid, option, npc)
                    local onPathUntraveled = player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.THE_PATH_UNTRAVELED and 1 or 0

                    player:updateEvent(0, 0, 0, 0, 0, 0, 0, onPathUntraveled)
                end,
            },

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [239] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                    npcUtil.giveKeyItem(player, xi.ki.SWORD_OFFERING)

                    if
                        not player:hasSpell(940) and
                        not player:hasItem(xi.items.CIPHER_OF_SEMIHS_ALTER_EGO)
                    then
                        npcUtil.giveItem(player, xi.items.CIPHER_OF_SEMIHS_ALTER_EGO)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Helaku'] = mission:messageText(northSandoriaID.text.THE_EMISSARY_PLACEHOLDER),
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Ada'] = mission:event(51),

            ['Gold_Skull'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        player:hasKeyItem(xi.ki.SWORD_OFFERING) and
                        not player:hasKeyItem(xi.ki.DULL_SWORD)
                    then
                        return mission:progressEvent(53) -- Trade Sword with fake.
                    elseif missionStatus <= 3 then -- After getting instructions and before getting Magic Sword.
                        return mission:event(50)
                    elseif missionStatus <= 6 then -- After trading Sword with fake and before reporting to Melek.
                        return mission:progressEvent(54)
                    end
                end,
            },

            ['Josef'] = mission:event(52),

            ['Melek'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus <= 5 then
                        return mission:progressEvent(49)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [53] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DULL_SWORD)
                    player:delKeyItem(xi.ki.SWORD_OFFERING)
                end,

                [55] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY)
                        player:setMissionStatus(mission.areaId, 7)
                    end
                end,
            },
        },
    },
}

return mission
