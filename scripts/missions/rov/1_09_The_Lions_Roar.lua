-----------------------------------
-- The Lion's Roar
-- Rhapsodies of Vana'diel Mission 1-9
-----------------------------------
-- !addmission 13 20
-- Undulating Confluence : !pos -204.531 -20.027 75.318 126
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local qufimID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_LIONS_ROAR)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_I },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Undulating_Confluence'] =
            {
                onTrigger = function(player, npc)
                    if npcUtil.popFromQM(player, npc, qufimID.mob.OPHIOTAURUS, { look = true, hide = 0 }) then
                        return mission:messageSpecial(qufimID.text.SENSE_OF_FOREBODING)
                    else
                        return mission:messageSpecial(qufimID.text.WAIT_A_BIT_LONGER)
                    end
                end,
            },

            ['Ophiotaurus'] =
            {
                onMobDeath = function(mob, player, optParams)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
