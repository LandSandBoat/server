-----------------------------------
-- Her Memories
-- Wings of the Goddess Mission 41
-----------------------------------
-- !addmission 5 40
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.HER_MEMORIES)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.FORGET_ME_NOT },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- NOTE: This mission is left intentionally blank at this time, as the entire mission logic
        -- is handled by subquests.  Completion of this mission is handled in
        -- xi.wotg.helpers.checkMemoryFragments
    },
}

return mission
