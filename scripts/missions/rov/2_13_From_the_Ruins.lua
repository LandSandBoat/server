-----------------------------------
-- Aphmau's Light
-- Rhapsodies of Vana'diel Mission 2-7
-----------------------------------
-- !addmission 13 62
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FROM_THE_RUINS)

mission.reward =
{
    keyItem = xi.ki.RHAPSODY_IN_CRIMSON,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CAUTERIZE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: The first two event parameters adjust based on WotG progress.  Implementation will need to be
                    -- adjusted as more captures become available, and is limited at this time to what has been observed.

                    local param0 = 0
                    local param1 = player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_WILL_OF_THE_WORLD)

                    return mission:progressEvent(169, { [0] = param0, [1] = param1, text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [169] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
