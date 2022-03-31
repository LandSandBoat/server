-----------------------------------
-- Reunited
-- Rhapsodies of Vana'diel Mission 2-10
-----------------------------------
-- !addmission 13 64
-- NPC: Nadeey
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.REUNITED)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.TAKE_WING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
             ['Nadeey'] =
            {
                -- Todo: Find trigger point
                -- 0 x x x candescence isnt there
                -- 1 x x x candescence is there
                -- x 0 x x Aphmau: I'm sure we'II be meeting again.
                -- x 1 x x Nashmerira: citizens must come first right now. Let's meet up later.
                -- no difference from other option

                onTrigger = function(player, npc)
                    if xi.rhapsodies.charactersAvailable(player) then
                        return mission:event(167, 0, 0, 0, 0, 0, 0, 0, 0, 0):setPriority(1005)
                        -- capture start @36min https://www.youtube.com/watch?v=mbQeJDyDpDk
                    end
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option, npc)
                   mission:complete(player)
                end,
            },
        },
    },
}

return mission
