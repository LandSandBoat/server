-----------------------------------
-- At Heaven's Door
-- Rhapsodies of Vana'diel Mission 1-8
-----------------------------------
-- !addmission 13 18
-- Undulating Confluence : !pos -204.531 -20.027 75.318 126
-----------------------------------
local norgID = zones[xi.zone.NORG]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.AT_THE_HEAVENS_DOOR)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_LIONS_ROAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Undulating_Confluence'] =
            {
                onTrigger = function(player, npc)
                    local isLionGhost = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS) and 1 or 0

                    return mission:event(63, { [7] = isLionGhost }):setPriority(1005)
                end,
            },

            onEventFinish =
            {
                [63] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['_700'] = mission:messageSpecial(norgID.text.DOOR_IS_LOCKED),
        },
    },
}

return mission
