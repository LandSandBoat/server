-----------------------------------
-- Prime Number
-- Rhapsodies of Vana'diel Mission 2-12
-----------------------------------
-- !addmission 13 68
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.PRIME_NUMBER)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.FROM_THE_RUINS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            onZoneIn =
            {
                function(player)
                    if xi.rhapsodies.charactersAvailable(player) then

                        -- Same cs as the capture with no parameter
                        return 125
                        -- capture @6min https://www.youtube.com/watch?v=_Ks5orwjMag

                    end
                end,
            },

            onEventFinish =
            {
                [125] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
