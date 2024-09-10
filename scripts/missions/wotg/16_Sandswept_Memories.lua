-----------------------------------
-- Sandswept Memories
-- Wings of the Goddess Mission 16
-----------------------------------
-- !addmission 5 15
-- Lion Springs Door : !pos 96 0 106 80
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.SANDSWEPT_MEMORIES)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.NORTHLAND_EXPOSURE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Lion_Springs'] =
            {
                onTrigger = function(player, npc)
                    -- Alternate Parameters : 1, 51, 3, 1, 1, 0, 0, 0
                    return mission:progressEvent(146, player:getCampaignAllegiance(), 0, 0, 0, 0, 0, 0, 4095)
                end,
            },

            onEventFinish =
            {
                [146] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
