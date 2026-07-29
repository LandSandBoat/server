-----------------------------------
-- The Mithra and the Crystal
-- Zilart M12
-----------------------------------
-- !addmission 3 23
-- Gilgamesh       : !pos 122.452 -9.009 -12.052 252
-- Maryoh_Comyujah : !pos 0 8 73 247
-- qm7             : !pos -504 20 -419 208
-- _6z0            : !pos 0 -12 48 251
-----------------------------------
local quicksandCavesID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS },
}

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Intro') == 0 then
                        return mission:progressEvent(111, 0, 1, 2, 0, 0, 0, 4352, 4)
                    else
                        return mission:event(69, 0, 1, 2, 0, 0, 0, 4352, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    mission:setVar(player, 'Intro', 1)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['_700'] = mission:event(5):replaceDefault(),

            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.CERULEAN_CRYSTAL) then
                        return mission:event(171)
                    else
                        return mission:event(170)
                    end
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:event(82),
        },
    },

    -- Section: Mission Active, missionStatus == 0
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] =
            {
                onTrigger = function(player, npc)
                    local hasDeclined = mission:getVar(player, 'Option')

                    return mission:progressEvent(81, 247, 1, 0, 708, 5, 1, 279, hasDeclined)
                end,
            },

            onEventFinish =
            {
                [81] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                    else
                        mission:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    -- Section: Mission Active, missionStatus == 1, does not have Scrap of Papyrus
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1 and not player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if mission:getLocalVar(player, 'nmDefeated') == 1 then
                        return mission:progressEvent(13)
                    else
                        return mission:progressEvent(12)
                    end
                end,
            },

            ['Ancient_Vessel'] =
            {
                onMobDeath = function(mob, player, optParams)
                    mission:setLocalVar(player, 'nmDefeated', 1)

                    if optParams.isKiller or optParams.noKiller then
                        mob:setLocalVar('[AncientVessel]Respawn', GetSystemTime() + 300)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    if option == 1 then
                        if player:checkDistance(npc) > 1.5 then
                            player:messageText(npc, quicksandCavesID.text.MUST_MOVE_CLOSER, false, 6)
                            return
                        end

                        local ancientVessel = GetMobByID(quicksandCavesID.mob.ANCIENT_VESSEL)
                        if not ancientVessel then
                            return
                        end

                        if ancientVessel:isSpawned() then
                            player:messageText(npc, quicksandCavesID.text.THIS_IS_NOT_THE_TIME, false, 6)
                        elseif GetSystemTime() < ancientVessel:getLocalVar('[AncientVessel]Respawn') then
                            player:messageText(npc, quicksandCavesID.text.FAINT_TRACES_OF_MAGIC, false, 6)
                        else
                            player:messageText(npc, quicksandCavesID.text.SOMETHING_ATTACKING_YOU, false, 6)

                            SpawnMob(quicksandCavesID.mob.ANCIENT_VESSEL):updateClaim(player)
                        end
                    end
                end,

                [13] = function(player, csid, option, npc)
                    if option == 1 then
                        if player:checkDistance(npc) > 1.5 then
                            player:messageText(npc, quicksandCavesID.text.MUST_MOVE_CLOSER, false, 6)
                            return
                        end

                        npcUtil.giveKeyItem(player, xi.ki.SCRAP_OF_PAPYRUS)
                    end
                end,
            },
        },
    },

    -- Section: Mission Active, has Scrap of Papyrus
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(83),

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
                    npcUtil.giveKeyItem(player, xi.ki.CERULEAN_CRYSTAL)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 2)
                end,
            },
        },
    },

    -- Section: Mission Active, missionStatus == 2
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(84),
        },
    },

    -- Section: Mission Active, has Cerulean Crystal
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasKeyItem(xi.ki.CERULEAN_CRYSTAL)
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            ['_6z0']              = mission:progressEvent(4),
            ['Shimmering_Circle'] = mission:progressEvent(3),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    -- Section: Mission Completed or Papyrus KI has been obtained
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) or
                player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    player:messageText(npc, quicksandCavesID.text.YOU_FIND_NOTHING, false, 6)

                    return mission:noAction()
                end,
            },
        },
    },

    -- Section: Mission Completed, Permanent Dialogue Change
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.RABAO] =
        {
            ['Maryoh_Comyujah'] = mission:progressEvent(85),
        },
    },
}

return mission
