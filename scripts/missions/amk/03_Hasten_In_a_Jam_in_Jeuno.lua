-----------------------------------
-- Hasten! In a Jam in Jeuno?
-- A Moogle Kupo d'Etat M3
-- Inconspicuous Door : !pos -15 1.300 68
-----------------------------------
-- !addmission 10 2
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10178)
                end,
            },

            onEventFinish =
            {
                [10178] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        -- Trade tracker for next mission
                        -- NOTE: This is set here to support the old mission format.
                        --       Replace when converting further missions.
                        player:setCharVar("AMK", 1)
                    end
                end,
            },
        },
    },
}

return mission
