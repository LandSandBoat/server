-----------------------------------
-- Northland Exposure
-- Wings of the Goddess Mission 17
-----------------------------------
-- !addmission 5 16
-- BEAUCEDINE_GLACIER_S : !zone 136
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.NORTHLAND_EXPOSURE)

mission.reward =
{
    keyItem     = xi.ki.SHADOW_BUG,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.TRAITOR_IN_THE_MIDST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 13
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
