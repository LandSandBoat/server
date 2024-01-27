-----------------------------------
-- Glimmer of Life
-- Wings of the Goddess Mission 44
-----------------------------------
-- !addmission 5 43
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.GLIMMER_OF_LIFE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.TIME_SLIPS_AWAY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] =
            {
                onTrigger = function(player, npc)
                    if
                        not mission:getMustZone(player) and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        -- NOTE: Contrary to some guides, it is not necessary to remove weapons to
                        -- receive this cutscene and complete the mission.

                        return mission:progressEvent(34, 89, 23, 1756, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
