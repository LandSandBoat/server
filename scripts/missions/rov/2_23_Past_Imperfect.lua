-----------------------------------
-- Past Imperfect
-- Rhapsodies of Vana'diel Mission 2-23
-----------------------------------
-- !addmission 13 100
-- Oaken Door : !pos 97 -7 -12 252
-----------------------------------
local norgID = zones[xi.zone.NORG]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.PAST_IMPERFECT)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_CURSED_TEMPLE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            -- NOTE: In observed captures, ZM2 took priority for first interaction with the Oaken Door.  This may be random,
            -- and is currently set to the same priority (Sample size of 1).  In addition, this event was blocked with CoP
            -- missions active (Dawn), which gave the messageSpecial below and falling back to event 5.

            ['_700'] =
            {
                onTrigger = function(player, npc)
                    if xi.rhapsodies.charactersAvailable(player) then
                        local rotzParam = 0

                        if player:getCurrentMission(xi.mission.log_id.ZILART) == xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH then
                            rotzParam = 1
                        elseif player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH) then
                            rotzParam = 2
                        end

                        return mission:progressEvent(286, rotzParam)
                    else
                        -- NOTE: This is a non-blocking message, but displayed on interaction with the door.
                        player:messageSpecial(norgID.text.UNABLE_TO_PROGRESS_MISSION, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [286] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
