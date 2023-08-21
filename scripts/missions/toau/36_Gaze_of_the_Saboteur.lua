-----------------------------------
-- Gaze of the Saboteur
-- Aht Uhrgan Mission 36
-----------------------------------
-- !addmission 4 35
-- Entry Gate : !pos 486 -227.6 -20 78
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.GAZE_OF_THE_SABOTEUR)

mission.reward =
{
    keyItem     = xi.ki.LUMINIAN_DAGGER,
    title       = xi.title.EMISSARY_OF_THE_EMPRESS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PATH_OF_BLOOD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HAZHALM_TESTING_GROUNDS] =
        {
            ['_260'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(7)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return 6
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
