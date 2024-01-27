-----------------------------------
-- A Day in the Life of a Pioneer
-- Seekers of Adoulin M4-1-5
-----------------------------------
-- !addmission 12 76
-- Levil   : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.A_DAY_IN_THE_LIFE_OF_A_PIONEER)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.LIGHTING_THE_WAY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    if
                        not mission:getMustZone(player) and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return mission:progressEvent(159, 0, 0, 292, 1)
                    else
                        return mission:event(164)
                    end
                end,
            },

            -- TODO: There was at least one event update option (1) which updated when selecting
            -- 'Like Yesterday.'  This may play along with the Arciela bond hidden variable.

            onEventFinish =
            {
                [159] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
