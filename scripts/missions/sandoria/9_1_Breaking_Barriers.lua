-----------------------------------
-- Breaking Barriers
-- San d'Oria M9-1
-----------------------------------
-- !addmission 0 22
-- Ambrotien                  : !pos 93.419 -0.001 -57.347 230
-- Grilau                     : !pos -241.987 6.999 57.887 231
-- Endracion                  : !pos -110 1 -34 230
-- (_6h4) Great Hall          : !pos 0 -1 13 233
-- qm_breaking_barriers (VoS) : !pos 91 -3 -16 128
-- qm5 (Xarcabard)            : !pos 179 -33 82 112
-- qm3 (Batallia Downs)       : !pos 210 17 -615 105
-----------------------------------
local batalliaID  = zones[xi.zone.BATALLIA_DOWNS]
local valleyID    = zones[xi.zone.VALLEY_OF_SORROWS]
local xarcabardID = zones[xi.zone.XARCABARD]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BREAKING_BARRIERS)

mission.reward =
{
    rankPoints = 900,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 22 then
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
            ['_6h4'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(32)
                    elseif
                        missionStatus == 4 and
                        player:hasKeyItem(xi.ki.FIGURE_OF_LEVIATHAN) and
                        player:hasKeyItem(xi.ki.FIGURE_OF_GARUDA) and
                        player:hasKeyItem(xi.ki.FIGURE_OF_TITAN)
                    then
                        return mission:progressEvent(76)
                    end
                end,
            },

            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(26)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(1)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [76] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.FIGURE_OF_LEVIATHAN)
                        player:delKeyItem(xi.ki.FIGURE_OF_GARUDA)
                        player:delKeyItem(xi.ki.FIGURE_OF_TITAN)
                    end
                end,
            },
        },

        [xi.zone.VALLEY_OF_SORROWS] =
        {
            ['qm_breaking_barriers'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(0)
                    else
                        return mission:messageSpecial(valleyID.text.SOMETHING_BURRIED)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FIGURE_OF_TITAN)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(12)
                    else
                        return mission:messageSpecial(xarcabardID.text.SOMETHING_BURIED)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FIGURE_OF_GARUDA)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    local suparnaMob = GetMobByID(batalliaID.mob.SUPARNA)
                    local fledglingMob = GetMobByID(batalliaID.mob.SUPARNA_FLEDGLING)

                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        suparnaMob and
                        fledglingMob and
                        (not suparnaMob:isSpawned() or suparnaMob:isDead()) and
                        (not fledglingMob:isSpawned() or fledglingMob:isDead())
                    then
                        if mission:getVar(player, 'Prog') > 0 then
                            return mission:progressEvent(904)
                        else
                            SpawnMob(batalliaID.mob.SUPARNA)
                            SpawnMob(batalliaID.mob.SUPARNA_FLEDGLING)
                            return mission:messageSpecial(batalliaID.text.SENSE_SOMETHING_LURKING)
                        end
                    else
                        return mission:messageSpecial(batalliaID.text.SOMEONE_HAS_BURIED)
                    end
                end,
            },

            ['Suparna'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobSuparnaFledgling = GetMobByID(batalliaID.mob.SUPARNA_FLEDGLING)

                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mobSuparnaFledgling and
                        (mobSuparnaFledgling:isDead() or not mobSuparnaFledgling:isSpawned())
                    then
                        mission:setVar(player, 'Prog', 1)
                    end
                end,
            },

            ['Suparna_Fledgling'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local mobSuparna = GetMobByID(batalliaID.mob.SUPARNA)

                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        mobSuparna and
                        (mobSuparna:isDead() or not mobSuparna:isSpawned())
                    then
                        mission:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [904] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FIGURE_OF_LEVIATHAN)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },
    },

    -- Optional dialogue after completing the Mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                currentMission ~= xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT
        end,

        ['Curilla'] = mission:event(16):replaceDefault(),
        ['Rahal']   = mission:event(37):replaceDefault(),
    },
}

return mission
