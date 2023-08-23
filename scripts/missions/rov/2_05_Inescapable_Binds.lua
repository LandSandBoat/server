-----------------------------------
-- Inescapable Binds
-- Rhapsodies of Vana'diel Mission 2-5
-----------------------------------
-- !addmission 13 52
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.INESCAPABLE_BINDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EVER_FORWARD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.rhapsodies.charactersAvailable(player) and
                player:hasKeyItem(xi.ki.BOARDING_PERMIT)
        end,

        -- There's two ways to complete this mission: Either by obtaining a Boarding Permit which
        -- will activate Desert Winds, or to zone into Aht Urhgan, which will complete this mission
        -- and activate Ever Forward.  The latter is what this script covers.

        -- For the scenario of obtaining a Boarding Permit, this mission is completed in the quest
        -- script for "The Road to Aht Urhgan"

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return { 165, 0 }
                end,
            },

            onEventUpdate =
            {
                [165] = function(player, csid, option, npc)
                    local toauProgress = player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.ROYAL_PUPPETEER and 1 or 0
                    local copProgress = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0

                    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.PASSING_GLORY) then
                        toauProgress = toauProgress + 1
                    end

                    -- NOTE: No capture has been provided with the second parameter being non-zero.  This may align with having
                    -- completed TOAU9, but no further progress made.  Not implemented at this time based on speculation.  These
                    -- breakpoints align with available caps, and may need future tweaking.

                    -- Warrior's Path ---------------------.
                    -- Plot foiled/Astral Cand. --------.  |
                    -- Palace/Salaheem/Trusted  -----.  |  |
                    --                               |  |  |
                    -- TOAU17 Completed           :  2, 0, 0
                    -- TOAU12 Completed           :  1, 0, 0
                    -- No TOAU Progress           :  0, 0, 0

                    player:updateEvent(toauProgress, 0, copProgress, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [165] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
