-----------------------------------
-- A Dreamy Interlude
-- Wings of the Goddess Mission 48
-----------------------------------
-- !addmission 5 47
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_DREAMY_INTERLUDE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_IN_THE_WOODS },
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
                        return mission:progressEvent(36, 89, 1, 596904, 1000, 0, 8323089, 0, 0)
                    else
                        return mission:progressEvent(27, 89, 12354, 59449, 120, 0, 8323089, 0, 0):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

    },
}

return mission
