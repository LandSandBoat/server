-----------------------------------
-- The Cursed Temple
-- Rhapsodies of Vana'diel Mission 2-24
-----------------------------------
-- !addmission 13 102
-- Granite Door (_4fx) : !pos 340 -1.899 331.656 159
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------
local uggalepihID = require('scripts/zones/Temple_of_Uggalepih/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_CURSED_TEMPLE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['_4fx'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
                    then
                        -- NOTE: The below parameters are based on full mission completion status, and will require additional captures
                        -- to determine the first and second parameter breakdown.

                        return mission:progressEvent(94, 1, 3, 340159, utils.MAX_UINT32 - 10, 323822, utils.MAX_UINT32 - 1813, 640938, 0)
                    else
                        -- NOTE: This is an intential fallthrough to default action.  onZoneIn event will also not occur
                        player:messageSpecial(uggalepihID.text.UNABLE_TO_PROGRESS_MISSION, 4)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    -- NOTE: This event appears to only be played if the player has completed ZM4 prior to logging this mission.  On
                    -- ZM4 complete, if this mission is active, the player will be moved to Wisdom of our Forefathers, where this
                    -- is not present.

                    if
                        player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH) and
                        mission:getVar(player, 'Status') == 0
                    then
                        return 93
                    end
                end,
            },

            onEventFinish =
            {
                [93] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [94] = function(player, csid, option, npc)
                    mission:complete(player)

                    player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS)
                    player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS)

                    player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHERE_DIVINITIES_COLLIDE)
                end,
            },
        },
    },
}

return mission
