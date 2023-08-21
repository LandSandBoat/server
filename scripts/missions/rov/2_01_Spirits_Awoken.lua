-----------------------------------
-- Spirits Awoken
-- Rhapsodies of Vana'diel Mission 2-1
-----------------------------------
-- !addmission 13 44
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SPIRITS_AWOKEN)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CRASHING_WAVES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.QUFIM_ISLAND then
                        return 51
                    end
                end,
            },

            onEventUpdate =
            {
                [51] = function(player, csid, option, npc)
                    if option == 1 then
                        -- Note: The below variable has a value of 2 in caps where the player is on "The Road Forks"; however,
                        -- the same version of the event is played.  This is the blocking event for progress in the next mission,
                        -- but will complete successfully here.
                        local completedVessel = player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.THE_ROAD_FORKS and 1 or 0

                        player:updateEvent(0, completedVessel, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
