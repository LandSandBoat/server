-----------------------------------
-- Infiltrate Davoi
-- San d'Oria M3-1
-----------------------------------
-- !addmission 0 10
-- Ambrotien            : !pos 93.419 -0.001 -57.347 230
-- Grilau               : !pos -241.987 6.999 57.887 231
-- Endracion            : !pos -110 1 -34 230
-- Door: Prince Royal's : !pos -38 -3 73 233
-- Quemaricond          : !pos 23 0.1 -23 149
-- Zantaviat            : !pos 215 0.1 -10 149
-- '!' East Block Code  : !pos 294 0 -28 149
-- '!' South Block Code : !pos 335.5 0 -136 149
-- '!' North Block Code : !pos 163 0 -18 149
-----------------------------------
local southernSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.INFILTRATE_DAVOI)

mission.reward =
{
    -- Rank Points: 400 First, 300 Repeat
    rankPoints = 300,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 110 then
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

    -- First time the player has accepted this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(1029)
                    elseif missionStatus == 4 then
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 55):setPriority(1000)
                    end
                end,
            },

        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(2029)
                    elseif missionStatus == 4 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 55):setPriority(1000)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(1029)
                    elseif missionStatus == 4 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 55):setPriority(1000)
                    end
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 4 then
                        return mission:progressEvent(554, 0, xi.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
                    elseif missionStatus == 0 then
                        return mission:progressEvent(553, 0, xi.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
                    end
                end,
            },

            onEventFinish =
            {
                [553] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [554] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
                        player:addRankPoints(100)
                    end
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['Quemaricond'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        npc:clearPath(true)
                        return mission:progressEvent(117)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return 116
                    end
                end,
            },

            onEventFinish =
            {
                [116] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [117] = function(player, csid, option, npc)
                    npc:continuePath()
                    player:setMissionStatus(mission.areaId, 4)
                    npcUtil.giveKeyItem(player, xi.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
                end,
            },
        },
    },

    -- Player is repeating this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 60):setPriority(1000)
                    elseif missionStatus == 10 then
                        return mission:progressEvent(1012)
                    end
                end,
            },

            onEventFinish =
            {
                [1012] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 60):setPriority(1000)
                    elseif missionStatus == 10 then
                        return mission:progressEvent(2012)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 60):setPriority(1000)
                    elseif missionStatus == 10 then
                        return mission:progressEvent(1012)
                    end
                end,
            },

            onEventFinish =
            {
                [1012] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [2012] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            -- TODO: Rename this NPC to be a non-special character, also separate these duplicate NPCs
            ['!'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 6 and missionStatus <= 9 then
                        local xPos = npc:getXPos()
                        local zPos = npc:getZPos()

                        if
                            xPos >= 292 and
                            xPos <= 296 and
                            zPos >= -30 and
                            zPos <= -26 and
                            not player:hasKeyItem(xi.ki.EAST_BLOCK_CODE)
                        then
                            player:setMissionStatus(player:getNation(), missionStatus + 1)
                            return mission:keyItem(xi.ki.EAST_BLOCK_CODE):setPriority(1000)
                        elseif
                            xPos >= 333 and
                            xPos <= 337 and
                            zPos >= -138 and
                            zPos <= -134 and
                            not player:hasKeyItem(xi.ki.SOUTH_BLOCK_CODE)
                        then
                            player:setMissionStatus(player:getNation(), missionStatus + 1)
                            return mission:keyItem(xi.ki.SOUTH_BLOCK_CODE):setPriority(1000)
                        elseif
                            xPos >= 161 and
                            xPos <= 165 and
                            zPos >= -20 and
                            zPos <= -16 and
                            not player:hasKeyItem(xi.ki.NORTH_BLOCK_CODE)
                        then
                            player:setMissionStatus(player:getNation(), missionStatus + 1)
                            return mission:keyItem(xi.ki.NORTH_BLOCK_CODE):setPriority(1000)
                        end
                    end
                end,
            },

            ['Zantaviat'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(102)
                    elseif missionStatus == 9 then
                        return mission:progressEvent(105)
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6)
                end,

                [105] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                    player:delKeyItem(xi.ki.EAST_BLOCK_CODE)
                    player:delKeyItem(xi.ki.SOUTH_BLOCK_CODE)
                    player:delKeyItem(xi.ki.NORTH_BLOCK_CODE)
                end,
            },
        },
    },
}

return mission
