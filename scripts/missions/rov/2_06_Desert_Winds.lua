-----------------------------------
-- Desert Winds
-- Rhapsodies of Vana'diel Mission 2-6
-----------------------------------
-- !addmission 13 54
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.DESERT_WINDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EVER_FORWARD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- We should be guaranteed that the player has not been to TOAU areas if this
        -- mission is active, but there could be the possibility that Unity Warp could
        -- bypass this.  Duplicating code across Inescapable Binds and this mission
        -- in order to ensure that this case is covered.  Event 164 was observed in caps,
        -- but no longer appears capable of displaying the palace-related cutscenes.

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
