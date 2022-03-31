-----------------------------------
-- Take Wing
-- Rhapsodies of Vana'diel Mission 2-11
-----------------------------------
-- !addmission 3 66
-- Region Shaharat Teahouse !pos (64, -7, -137,  95, -5, -123)
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TAKE_WING)
mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.PRIME_NUMBER },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onRegionEnter =
            {
                [5] = function(player, region)

                    if xi.rhapsodies.charactersAvailable(player) then

                        -- Todo: Find trigger point
                        -- 0 x x x default relashion with Tenzen
                        -- 1 x x x Tenzen: let us set the past aside (negative impression of Tenzen)
                        -- x x x 0 uses Alphau name
                        -- x x x 1 uses Nashmeira name
                        -- no difference from other option

                        return mission:progressEvent(168, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                        -- capture @40min https://www.youtube.com/watch?v=mbQeJDyDpDk

                    end
                end,
            },

            onEventFinish =
            {
                [168] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
