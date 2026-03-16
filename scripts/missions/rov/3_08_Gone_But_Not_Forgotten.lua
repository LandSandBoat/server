-----------------------------------
-- Gone but Not Forgotten
-- Rhapsodies of Vana'diel Mission 3-8
-----------------------------------
-- !addmission 13 160
-- Rala Waterways - Teodor/Balamor cutscene (event 367)
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.GONE_BUT_NOT_FORGOTTEN)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.AUGUST_ARTIFACTS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            onZoneIn = function(player, prevZone)
                return 367
            end,

            onEventFinish =
            {
                [367] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
