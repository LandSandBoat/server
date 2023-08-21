-----------------------------------
-- Numbering Days
-- Rhapsodies of Vana'diel Mission 2-4
-----------------------------------
-- !addmission 13 50
-- Marble Bridge Eatery (Door) : !pos -96.6 -0.2 92.3 244
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.NUMBERING_DAYS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.INESCAPABLE_BINDS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    -- Note: While the second and third parameters change based on below observations, they
                    -- do not appear to have an impact on the event.  The first parameter with a value of 0
                    -- has Prishe ready to fight the masked man, and with a value of 1, she appears very calm
                    -- and proper.  A 1-value was not observed in caps, and is not implemented at this time.

                    -- Unknown -----------------------------.
                    -- Unknown --------------------------.  |
                    -- Unknown -----------------------.  |  |
                    -- See Notes Above ------------.  |  |  |
                    --                             |  |  |  |
                    -- Darkness Named            : 0, 1, 1, 0
                    -- >= Flames in the Darkness : 0, 2, 1, 0

                    local promathiaMission = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and 1 or 0

                    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.FLAMES_IN_THE_DARKNESS then
                        promathiaMission = promathiaMission + 1
                    end

                    return mission:progressEvent(10221, 0, promathiaMission, 1, 0):setPriority(1005)
                end,
            },

            onEventFinish =
            {
                [10221] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
