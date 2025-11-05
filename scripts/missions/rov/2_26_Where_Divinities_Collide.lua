-----------------------------------
-- Where Divinities Collide
-- Rhapsodies of Vana'diel Mission 2-26
-----------------------------------
-- !addmission rov where_divinities_collide
-- Shattered Telepoint (Mea)   : !pos 180 35 257 117
-- Shattered Telepoint (Holla) : !pos 336 19 -60 102
-- Shattered Telepoint (Dem)   : !pos 138 19 219 108
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WHERE_DIVINITIES_COLLIDE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.VISIONS_OF_DREAD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,
        
        [xi.zone.HALL_OF_TRANSFERENCE] =
        {
            onZoneIn = function(player, prevZone)
                return 2
            end,

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        -- NOTE: It is not immediately clear what these event parameters represent, further captures needed.
                        player:updateEvent(0, 23, 2964, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:complete(player)
                    -- Player gets zoned once again to trigger the next CS (4)
                    -- https://www.youtube.com/watch?v=1wGmmxbu6sM 11:29
                    player:setPos(0, 0, 0, 0, xi.zone.HALL_OF_TRANSFERENCE)
                end,
            },
        },
    },
}

return mission
