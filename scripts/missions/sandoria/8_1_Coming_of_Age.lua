-----------------------------------
-- Coming of Age
-- San d'Oria M8-1
-----------------------------------
-- !addmission 0 20
-- Ambrotien             : !pos 93.419 -0.001 -57.347 230
-- Grilau                : !pos -241.987 6.999 57.887 231
-- Endracion             : !pos -110 1 -34 230
-- Halver                : !pos 2 0.1 0.1 233
-- Fountain of Kings     : !pos 567 18 -939 208
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local quicksandCavesID   = require('scripts/zones/Quicksand_Caves/IDs')
local southernSandoriaID = require('scripts/zones/Southern_San_dOria/IDs')
local northernSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.COMING_OF_AGE)

mission.reward =
{
    rankPoints = 800,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 20 then
        mission:begin(player)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(58)
                    elseif
                        missionStatus == 3 and
                        player:hasKeyItem(xi.ki.DROPS_OF_AMNIO)
                    then
                        return mission:progressEvent(102)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return 116
                    end
                end,
            },

            onEventFinish =
            {
                [58] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [102] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        -- This cutscene is blocking after the mission has been completed.  Check this
                        -- before allowing further gate guard interaction (Mission[0][20]Progress).  Required
                        -- final CS will set this to 0, and we should disallow on non-zero values
                        mission:setVar(player, 'Progress', os.time() + 60)
                        player:delKeyItem(xi.ki.DROPS_OF_AMNIO)
                    end
                end,

                [116] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['Fountain_of_Kings'] =
            {
                onTrigger = function(player, npc)
                    local mobHonor = GetMobByID(quicksandCavesID.mob.VALOR)
                    local mobValor = GetMobByID(quicksandCavesID.mob.HONOR)

                    if
                        (not mobHonor:isSpawned() or mobHonor:isDead()) and
                        (not mobValor:isSpawned() or mobValor:isDead())
                    then
                        local missionStatus = player:getMissionStatus(mission.areaId)

                        if missionStatus == 2 then
                            SpawnMob(quicksandCavesID.mob.VALOR)
                            SpawnMob(quicksandCavesID.mob.HONOR)
                            return mission:messageSpecial(quicksandCavesID.text.SENSE_SOMETHING_EVIL)
                        elseif missionStatus == 3 and not player:hasKeyItem(xi.ki.DROPS_OF_AMNIO) then
                            return mission:keyItem(xi.ki.DROPS_OF_AMNIO)
                        end
                    end
                end,
            },

            -- Only one of these NMs are required to progress, but the mob must despawn while in combat with
            -- the other target.
            ['Honor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobValor = GetMobByID(quicksandCavesID.mob.HONOR)

                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        (mobValor:isDead() or not mobValor:isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },

            ['Valor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobHonor = GetMobByID(quicksandCavesID.mob.VALOR)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        (mobHonor:isDead() or not mobHonor:isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },
    },

    -- Player has completed the mission and requires the final cutscene.  Guards are blocked until that time.  There is an additional
    -- dialogue that exists if wait time is less than required (OFFSET + 126); however, modern requirement is only one minute.  It is
    -- highly unlikely that this scenario will ever be hit.
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                mission:getVar(player, 'Progress') > 0
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] = mission:messageSpecial(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 127):setPriority(1000),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Progress') < os.time() then
                        return 16
                    end
                end
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    mission:setVar(player, 'Progress', 0)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] = mission:messageSpecial(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 127):setPriority(1000),
            ['Endracion'] = mission:messageSpecial(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 127):setPriority(1000),
        },
    },
}

return mission
