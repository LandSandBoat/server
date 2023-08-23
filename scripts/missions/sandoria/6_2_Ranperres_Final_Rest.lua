-----------------------------------
-- Ranperre's Final Rest
-- San d'Oria M6-2
-----------------------------------
-- !addmission 0 17
-- Ambrotien            : !pos 93.419 -0.001 -57.347 230
-- Grilau               : !pos -241.987 6.999 57.887 231
-- Endracion            : !pos -110 1 -34 230
-- Halver               : !pos 2 0.1 0.1 233
-- Door: Prince Royal's : !pos -38 -3 73 233
-- _5a0: Heavy Stone Dr : !pos -39 4.823 20 190
-- Tombstone            : !pos -73.594 7.585 20.130 190
-----------------------------------
local krtID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.RANPERRES_FINAL_REST)

mission.reward =
{
    rank = 7,
    gil = 40000,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 17 then
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
            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(81)
                    elseif missionStatus == 5 then
                        return mission:progressEvent(21)
                    elseif missionStatus == 7 then
                        return mission:progressEvent(79)
                    end
                end,
            },

            ['Perfaumand'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        player:hasKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK) and
                        missionStatus > 2 and
                        missionStatus < 6
                    then
                        return mission:progressEvent(49)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(50)
                    elseif missionStatus == 7 then
                        return mission:progressEvent(79)
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6)
                end,

                [81] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },

        [xi.zone.KING_RANPERRES_TOMB] =
        {
            ['_5a0'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus == 1 and
                        not GetMobByID(krtID.mob.CORRUPTED_YORGOS):isSpawned() and
                        not GetMobByID(krtID.mob.CORRUPTED_SOFFEIL):isSpawned() and
                        not GetMobByID(krtID.mob.CORRUPTED_ULBRIG):isSpawned()
                    then
                        SpawnMob(krtID.mob.CORRUPTED_YORGOS)
                        SpawnMob(krtID.mob.CORRUPTED_SOFFEIL)
                        SpawnMob(krtID.mob.CORRUPTED_ULBRIG)
                        return mission:messageSpecial(krtID.text.SENSE_SOMETHING_EVIL)
                    elseif
                        (missionStatus == 2 or missionStatus == 3) and
                        player:getXPos() > -39.019
                    then
                        return mission:progressEvent(6)
                    elseif missionStatus == 3 and player:getXPos() <= -39.019 then
                        return mission:progressEvent(7)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(5)
                    end
                end,
            },

            ['Corrupted_Soffeil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (GetMobByID(krtID.mob.CORRUPTED_YORGOS):isDead() or not GetMobByID(krtID.mob.CORRUPTED_YORGOS):isSpawned()) and
                        (GetMobByID(krtID.mob.CORRUPTED_ULBRIG):isDead() or not GetMobByID(krtID.mob.CORRUPTED_ULBRIG):isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            ['Corrupted_Ulbrig'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (GetMobByID(krtID.mob.CORRUPTED_YORGOS):isDead() or not GetMobByID(krtID.mob.CORRUPTED_YORGOS):isSpawned()) and
                        (GetMobByID(krtID.mob.CORRUPTED_SOFFEIL):isDead() or not GetMobByID(krtID.mob.CORRUPTED_SOFFEIL):isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            ['Corrupted_Yorgos'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (GetMobByID(krtID.mob.CORRUPTED_ULBRIG):isDead() or not GetMobByID(krtID.mob.CORRUPTED_ULBRIG):isSpawned()) and
                        (GetMobByID(krtID.mob.CORRUPTED_SOFFEIL):isDead() or not GetMobByID(krtID.mob.CORRUPTED_SOFFEIL):isSpawned())
                    then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            -- TODO: This is another duplicate NPC in the database, separate these eventually
            ['Tombstone'] =
            {
                onTrigger = function(player, npc)
                    if
                        npc:getZPos() > 0 and
                        player:getMissionStatus(mission.areaId) == 3 and
                        not player:hasKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK)
                    then
                        return mission:progressEvent(8)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 7)
                end,

                [6] = function(player, csid, option, npc)
                    -- Only set this status when they have not cancelled the CS.  Event Option is not
                    -- changed when 'No' is selected.
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        player:getXPos() <= -39.019
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,

                [8] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ANCIENT_SAN_DORIAN_BOOK)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if player:hasKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK) then
                        return mission:progressEvent(1036)
                    elseif missionStatus == 4 then
                        if player:getLocalVar('Mission[0][17]requiredToZone') == 1 then
                            return mission:progressEvent(1038)
                        else
                            return mission:progressEvent(1040)
                        end
                    elseif missionStatus == 7 then
                        return mission:progressEvent(1034)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if player:hasKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK) then
                        return mission:progressEvent(1035)
                    elseif missionStatus == 4 then
                        if player:getLocalVar('Mission[0][17]requiredToZone') == 1 then
                            return mission:progressEvent(1037)
                        else
                            return mission:progressEvent(1039)
                        end
                    elseif missionStatus == 7 then
                        return mission:progressEvent(1033)
                    end
                end,
            },

            onEventFinish =
            {
                [1033] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [1034] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [1035] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK)
                    player:setLocalVar('Mission[0][17]requiredToZone', 1)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [1036] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK)
                    player:setLocalVar('Mission[0][17]requiredToZone', 1)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [1039] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                end,

                [1040] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                end,
            }
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if player:hasKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK) then
                        return mission:progressEvent(1035)
                    elseif missionStatus == 4 then
                        if player:getLocalVar('Mission[0][17]requiredToZone') == 1 then
                            return mission:progressEvent(1037)
                        else
                            return mission:progressEvent(1039)
                        end
                    elseif missionStatus == 7 then
                        return mission:progressEvent(1033)
                    end
                end,
            },

            onEventFinish =
            {
                [1033] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [1035] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ANCIENT_SAN_DORIAN_BOOK)
                    player:setLocalVar('Mission[0][17]requiredToZone', 1)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [1039] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                end,
            }
        },
    },
}

return mission
