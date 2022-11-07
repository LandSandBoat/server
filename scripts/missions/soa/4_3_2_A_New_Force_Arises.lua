-----------------------------------
-- A New Force Arises
-- Seekers of Adoulin M4-3-2
-----------------------------------
-- !addmission 12 85
-- Levil               : !pos -87.204 3.350 12.655 256
-- Alpine Trail        : !pos -13.479 -1.047 488.863 267
-- Effigy of Sealing 1 : !pos -496 -178 336 274
-- Effigy of Sealing 2 : !pos -424 -178 -376 274
-- _7mw                : !pos 197 58 -20 274
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local kamihrID        = require('scripts/zones/Mount_Kamihr/IDs')
local outerRaKaznarID = require('scripts/zones/Outer_RaKaznar/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.A_NEW_FORCE_ARISES)

mission.reward =
{
    keyItem     = xi.ki.WORLD_TREE_SAPLING,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_SACRED_SAPLING },
}

local scaleKeyItems =
{
    xi.ki.SUNKISSED_SCALE,
    xi.ki.MOONTOUCHED_SCALE,
    xi.ki.STARBLESSED_SCALE,
}

local function getNumScales(player)
    local numScales = 0

    for _, keyItem in ipairs(scaleKeyItems) do
        if player:hasKeyItem(keyItem) then
            numScales = numScales + 1
        end
    end

    return numScales
end

local function scaleMessage(player)
    local numScales = getNumScales(player)

    player:messageSpecial(outerRaKaznarID.text.HAVE_FOUND_SCALES, numScales)

    if numScales == 3 then
    player:messageSpecial(outerRaKaznarID.text.SOOTHING_SIGH_FALLS)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CELENNIA_MEMORIAL_LIBRARY] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local numScales = getNumScales(player)

                    if
                        numScales > 0 and
                        numScales < 3 and
                        not mission:isVarBitsSet(player, 'Option', 0)
                    then
                        return 6
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Alpine_Trail'] =
            {
                onTrigger = function(player, npc)
                    local numScales = getNumScales(player)

                    if
                        numScales > 0 and
                        numScales < 3 and
                        not mission:isVarBitsSet(player, 'Option', 1)
                    then
                        return mission:progressEvent(55)
                    elseif numScales == 3 then
                        return mission:progressEvent(56, 267, 80, 6, 3, 0, 1, 5, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setPos(306.42, -0.051, -24.974, 199, xi.zone.MOUNT_KAMIHR)
                    end
                end,

                [56] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setPos(306.42, -0.051, -24.974, 199, xi.zone.MOUNT_KAMIHR)
                    end
                end,
            },
        },

        [xi.zone.MOUNT_KAMIHR] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local numScales = getNumScales(player)

                    if numScales ~= 3 then
                        return 4
                    else
                        return 5
                    end
                end,
            },

            onEventUpdate =
            {
                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(8, 23, 1756, 0, 0, 1, 0, 0)
                    end
                end,

                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(282, 2935914, 1756, 0, 0, 1, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 1)
                    player:setPos(-8.495, 0.454, 487.467, 12, xi.zone.KAMIHR_DRIFTS)
                end,

                [5] = function(player, csid, option, npc)
                    for _, keyItem in ipairs(scaleKeyItems) do
                        player:delKeyItem(keyItem)
                        player:messageSpecial(kamihrID.text.LOST_KEYITEM, keyItem)
                    end

                    mission:complete(player)
                    player:setPos(-8.495, 0.454, 487.467, 12, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(165),
        },

        [xi.zone.OUTER_RAKAZNAR] =
        {
            ['_7mw'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SUNKISSED_SCALE) then
                        return mission:progressEvent(51, 274, 300, 200, 100, utils.MAX_UINT32 - 307959, 234, 582330, 8)
                    end
                end,
            },

            ['Effigy_of_Sealing_1'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.MOONTOUCHED_SCALE) then
                        return mission:progressEvent(52, 274, 300, 200, 100, 239663, 663, 250000, 0)
                    end
                end,
            },

            ['Effigy_of_Sealing_2'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.STARBLESSED_SCALE) then
                        return mission:progressEvent(53, 274, 300, 200, 100, 289440, 1681, 568030, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SUNKISSED_SCALE)
                    scaleMessage(player)
                end,

                [52] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MOONTOUCHED_SCALE)
                    scaleMessage(player)
                end,

                [53] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.STARBLESSED_SCALE)
                    scaleMessage(player)
                end,
            },
        },
    },
}

return mission
