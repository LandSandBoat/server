-----------------------------------
-- The Key to the Turris
-- Seekers of Adoulin M5-2-2
-----------------------------------
-- !addmission 12 114
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_KEY_TO_THE_TURRIS)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.TEODORS_SUMMONS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 5, 0, 0, 0, 0, 4),
        },

        [xi.zone.RAKAZNAR_TURRIS] =
        {
            ['Ominous_Postern'] = mission:progressEvent(1, 0, 3530831, 2964, 627, 277, 1, 0, 0),

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(-277.5, 19.999, 59.9, 0, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 58
                    end
                end,
            },

            onEventFinish =
            {
                [58] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
