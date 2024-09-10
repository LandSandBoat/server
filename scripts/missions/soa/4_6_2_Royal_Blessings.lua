-----------------------------------
-- Royal Blessings
-- Seekers of Adoulin M4-6-2
-----------------------------------
-- !addmission 12 107
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ROYAL_BLESSINGS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ARBOREAL_RUMORS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            -- NOTE: Contrary to BG Wiki, there is not a game-day wait prior to this
            -- event becoming available.
            ['Levil'] = mission:progressEvent(178, 256, 0, 1, 0, 0, 0, 0, 4),

            onEventFinish =
            {
                [178] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
