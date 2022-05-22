-----------------------------------
-- A Shantotto Ascension
-- A Shantotto Ascension M4
-----------------------------------
-- !addmission 11 3
-- Trodden Snow  : !pos -19.7 -17.3 104.4 126
-----------------------------------
require('scripts/globals/missions')
require('scripts/settings/main')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local flamesID  = require("scripts/zones/Cloister_of_Flames/IDs")
local frostID   = require("scripts/zones/Cloister_of_Frost/IDs")
local galesID   = require("scripts/zones/Cloister_of_Gales/IDs")
local stormsID  = require("scripts/zones/Cloister_of_Storms/IDs")
local tidesID   = require("scripts/zones/Cloister_of_Tides/IDs")
local tremorsID = require("scripts/zones/Cloister_of_Tremors/IDs")
local qufimID   = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CLOISTER_OF_FLAMES] =
        {
            ['Fire_Protocrystal'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.DOMINAS_SCARLET_SEAL) and mission:getVar(player, 'Ifrit') == 0 then
                        mission:setVar(player, 'Ifrit', 1)
                        return mission:messageSpecial(flamesID.text.POWER_STYMIES, xi.keyItem.DOMINAS_SCARLET_SEAL)
                    elseif player:hasKeyItem(xi.ki.DOMINAS_SCARLET_SEAL) and mission:getVar(player, 'Ifrit') == 2 then
                        mission:setVar(player, 'Ifrit', 3)
                        return mission:progressEvent(2)
                    end
                end,

                onEventFinish =
                {
                    [2] = function(player, csid, option, npc)
                        player:delKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
                        player:addKeyItem(xi.ki.SCARLET_COUNTERSEAL)
                        player:messageSpecial(flamesID.text.ATTACH_SEAL, xi.ki.DOMINAS_SCARLET_SEAL)
                        player:messageSpecial(flamesID.text.KEYITEM_OBTAINED, xi.ki.SCARLET_COUNTERSEAL)
                        local sealCount = mission:getVar(player, 'SealCount')
                        mission:setVar(player, 'SealCount', sealCount + 1)
                    end,
                }
            },
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['Ice_Protocrystal'] =
            {
                onTrigger = function(player, npc)
                    local asaPrimal = mission:getVar(player, 'Shiva')

                    if player:hasKeyItem(xi.ki.DOMINAS_AZURE_SEAL) and asaPrimal == 0 then
                        mission:setVar(player, 'Shiva', 1)
                        return mission:messageSpecial(frostID.text.POWER_STYMIES, xi.keyItem.DOMINAS_AZURE_SEAL)
                    elseif player:hasKeyItem(xi.ki.DOMINAS_AZURE_SEAL) and asaPrimal == 2 then
                        mission:setVar(player, 'Shiva', 3)
                        return mission:progressEvent(2)
                    end
                end,

                onEventFinish =
                {
                    [2] = function(player, csid, option, npc)
                        player:delKeyItem(xi.ki.DOMINAS_AZURE_SEAL)
                        player:addKeyItem(xi.ki.AZURE_COUNTERSEAL)
                        player:messageSpecial(frostID.text.ATTACH_SEAL, xi.ki.DOMINAS_AZURE_SEAL)
                        player:messageSpecial(frostID.text.KEYITEM_OBTAINED, xi.ki.AZURE_COUNTERSEAL)
                        local sealCount = mission:getVar(player, 'SealCount')
                        mission:setVar(player, 'SealCount', sealCount + 1)
                    end,
                }
            },
        },

        [xi.zone.CLOISTER_OF_GALES] =
        {
            ['Wind_Protocrystal'] =
            {
                onTrigger = function(player, npc)
                    local asaPrimal = mission:getVar(player, 'Garuda')

                    if player:hasKeyItem(xi.ki.DOMINAS_EMERALD_SEAL) and asaPrimal == 0 then
                        mission:setVar(player, 'Garuda', 1)
                        return mission:messageSpecial(galesID.text.POWER_STYMIES, xi.keyItem.DOMINAS_EMERALD_SEAL)
                    elseif player:hasKeyItem(xi.ki.DOMINAS_EMERALD_SEAL) and asaPrimal == 2 then
                        mission:setVar(player, 'Garuda', 3)
                        return mission:progressEvent(2)
                    end
                end,

                onEventFinish =
                {
                    [2] = function(player, csid, option, npc)
                        player:delKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
                        player:addKeyItem(xi.ki.EMERALD_COUNTERSEAL)
                        player:messageSpecial(galesID.text.ATTACH_SEAL, xi.ki.DOMINAS_EMERALD_SEAL)
                        player:messageSpecial(galesID.text.KEYITEM_OBTAINED, xi.ki.EMERALD_COUNTERSEAL)
                        local sealCount = mission:getVar(player, 'SealCount')
                        mission:setVar(player, 'SealCount', sealCount + 1)
                    end,
                }
            },
        },

        [xi.zone.CLOISTER_OF_STORMS] =
        {
            ['Lightning_Protocrystal'] =
            {
                onTrigger = function(player, npc)
                    local asaPrimal = mission:getVar(player, 'Ramuh')

                    if player:hasKeyItem(xi.ki.DOMINAS_VIOLET_SEAL) and asaPrimal == 0 then
                        mission:setVar(player, 'Ramuh', 1)
                        return mission:messageSpecial(stormsID.text.POWER_STYMIES, xi.keyItem.DOMINAS_VIOLET_SEAL)
                    elseif player:hasKeyItem(xi.ki.DOMINAS_VIOLET_SEAL) and asaPrimal == 2 then
                        mission:setVar(player, 'Ramuh', 3)
                        return mission:progressEvent(2)
                    end
                end,

                onEventFinish =
                {
                    [2] = function(player, csid, option, npc)
                        player:delKeyItem(xi.ki.DOMINAS_VIOLET_SEAL)
                        player:addKeyItem(xi.ki.VIOLET_COUNTERSEAL)
                        player:messageSpecial(stormsID.text.ATTACH_SEAL, xi.ki.DOMINAS_VIOLET_SEAL)
                        player:messageSpecial(stormsID.text.KEYITEM_OBTAINED, xi.ki.VIOLET_COUNTERSEAL)
                        local sealCount = mission:getVar(player, 'SealCount')
                        mission:setVar(player, 'SealCount', sealCount + 1)
                    end,
                }
            },
        },

        [xi.zone.CLOISTER_OF_TIDES] =
        {
            ['Water_Protocrystal'] =
            {
                onTrigger = function(player, npc)
                    local asaPrimal = mission:getVar(player, 'Leviathan')

                    if player:hasKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL) and asaPrimal == 0 then
                        mission:setVar(player, 'Leviathan', 1)
                        return mission:messageSpecial(tidesID.text.POWER_STYMIES, xi.keyItem.DOMINAS_CERULEAN_SEAL)
                    elseif player:hasKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL) and asaPrimal == 2 then
                        mission:setVar(player, 'Leviathan', 3)
                        return mission:progressEvent(2)
                    end
                end,

                onEventFinish =
                {
                    [2] = function(player, csid, option, npc)
                        player:delKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)
                        player:addKeyItem(xi.ki.CERULEAN_COUNTERSEAL)
                        player:messageSpecial(tidesID.text.ATTACH_SEAL, xi.ki.DOMINAS_CERULEAN_SEAL)
                        player:messageSpecial(tidesID.text.KEYITEM_OBTAINED, xi.ki.CERULEAN_COUNTERSEAL)
                        local sealCount = mission:getVar(player, 'SealCount')
                        mission:setVar(player, 'SealCount', sealCount + 1)
                    end,
                }
            },
        },

        [xi.zone.CLOISTER_OF_TREMORS] =
        {
            ['Earth_Protocrystal'] =
            {
                onTrigger = function(player, npc)
                    local asaPrimal = mission:getVar(player, 'Titan')

                    if player:hasKeyItem(xi.ki.DOMINAS_AMBER_SEAL) and asaPrimal == 0 then
                        mission:setVar(player, 'Titan', 1)
                        return mission:messageSpecial(tremorsID.text.POWER_STYMIES, xi.keyItem.DOMINAS_AMBER_SEAL)
                    elseif player:hasKeyItem(xi.ki.DOMINAS_AMBER_SEAL) and asaPrimal == 2 then
                        mission:setVar(player, 'Titan', 3)
                        return mission:progressEvent(2)
                    end
                end,

                onEventFinish =
                {
                    [2] = function(player, csid, option, npc)
                        player:delKeyItem(xi.ki.DOMINAS_AMBER_SEAL)
                        player:addKeyItem(xi.ki.AMBER_COUNTERSEAL)
                        player:messageSpecial(tremorsID.text.ATTACH_SEAL, xi.ki.DOMINAS_AMBER_SEAL)
                        player:messageSpecial(tremorsID.text.KEYITEM_OBTAINED, xi.ki.AMBER_COUNTERSEAL)
                        local sealCount = mission:getVar(player, 'SealCount')
                        mission:setVar(player, 'SealCount', sealCount + 1)
                    end,
                }
            },
        },

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Trodden_Snow'] =
            {
                onTrigger = function(player, npc)
                    --ASA 4 CS: Triggers With At Least 3 Counterseals.
                    local completedSeals =
                        (player:hasKeyItem(xi.ki.AMBER_COUNTERSEAL)    and 1 or 0) +
                        (player:hasKeyItem(xi.ki.AZURE_COUNTERSEAL)    and 1 or 0) +
                        (player:hasKeyItem(xi.ki.CERULEAN_COUNTERSEAL) and 1 or 0) +
                        (player:hasKeyItem(xi.ki.EMERALD_COUNTERSEAL)  and 1 or 0) +
                        (player:hasKeyItem(xi.ki.SCARLET_COUNTERSEAL)  and 1 or 0) +
                        (player:hasKeyItem(xi.ki.VIOLET_COUNTERSEAL)   and 1 or 0)

                    if completedSeals >= 3 then
                        mission:setVar(player, 'SealCount', completedSeals)
                        return mission:progressEvent(45)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    local completedSeals = mission:getVar(player, 'SealCount')

                    -- Calculate Reward
                    if completedSeals == 3 then
                        player:addGil(xi.settings.GIL_RATE * 3000)
                        player:messageSpecial(qufimID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 3000)
                    elseif completedSeals == 4 then
                        player:addGil(xi.settings.GIL_RATE * 10000)
                        player:messageSpecial(qufimID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 10000)
                    elseif completedSeals == 5 then
                        player:addGil(xi.settings.GIL_RATE * 30000)
                        player:messageSpecial(qufimID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 30000)
                    elseif completedSeals == 6 then
                        player:addGil(xi.settings.GIL_RATE * 50000)
                        player:messageSpecial(qufimID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 50000)
                    end

                    -- Clean Up Remaining Key Items
                    player:delKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
                    player:delKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)
                    player:delKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
                    player:delKeyItem(xi.ki.DOMINAS_AMBER_SEAL)
                    player:delKeyItem(xi.ki.DOMINAS_VIOLET_SEAL)
                    player:delKeyItem(xi.ki.DOMINAS_AZURE_SEAL)

                    player:delKeyItem(xi.ki.SCARLET_COUNTERSEAL)
                    player:delKeyItem(xi.ki.CERULEAN_COUNTERSEAL)
                    player:delKeyItem(xi.ki.EMERALD_COUNTERSEAL)
                    player:delKeyItem(xi.ki.AMBER_COUNTERSEAL)
                    player:delKeyItem(xi.ki.VIOLET_COUNTERSEAL)
                    player:delKeyItem(xi.ki.AZURE_COUNTERSEAL)

                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
