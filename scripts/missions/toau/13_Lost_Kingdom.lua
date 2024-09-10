-----------------------------------
-- Lost Kingdom
-- Aht Uhrgan Mission 13
-----------------------------------
-- !addmission 4 12
-- Pyopyoroon           : !pos 22.112 0 24.682 53
-- Jazaraat's Headstone : !pos -389 6 -570 79
-----------------------------------
local caedarvaID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.LOST_KINGDOM)

mission.reward =
{
    keyItem     = xi.ki.EPHRAMADIAN_GOLD_COIN,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.THE_DOLPHIN_CREST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Jazaraats_Headstone'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus == 0 and
                        player:hasKeyItem(xi.ki.VIAL_OF_SPECTRAL_SCENT)
                    then
                        return mission:progressEvent(8)
                    elseif
                        missionStatus == 1 and
                        not GetMobByID(caedarvaID.mob.JAZARAAT):isSpawned()
                    then
                        SpawnMob(caedarvaID.mob.JAZARAAT):updateEnmity(player)
                        -- There is no message returned here in captures
                        return mission:noAction()
                    elseif missionStatus == 2 then
                        return mission:progressEvent(9)
                    end
                end,
            },

            ['Jazaraat'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    player:delKeyItem(xi.ki.VIAL_OF_SPECTRAL_SCENT)
                end,

                [9] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            ['Pyopyoroon'] = mission:progressEvent(275),
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['Jazaraats_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN) then
                        return mission:keyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
                    else
                        return mission:messageSpecial(caedarvaID.text.JAZARAATS_HEADSTONE)
                    end
                end,
            },
        },
    },
}

return mission
