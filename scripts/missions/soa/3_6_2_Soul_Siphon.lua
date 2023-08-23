-----------------------------------
-- Soul Siphon
-- Seekers of Adoulin M3-6-2
-----------------------------------
-- !addmission 12 66
-- Hollowed Pathway : !pos 215.371 39.025 -446.368 267
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.SOUL_SIPHON)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.STONEWALLED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(152),
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Hollowed_Pathway'] = mission:progressEvent(32),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        mission:complete(player)
                    end
                end,
            },

            onEventFinish =
            {
                [32] = function(player, csid, option, npc)
                    if option == 0 then
                        mission:setVar(player, 'Status', 1)
                        player:setPos(495.312, 29.905, 379.563, 112, xi.zone.CIRDAS_CAVERNS)
                    end
                end,
            },
        },

        [xi.zone.CIRDAS_CAVERNS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 29
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(-210.208, 40.218, -447.346, 243, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },
    },
}

return mission
