-----------------------------------
-- Morimar
-- Seekers of Adoulin M4-3-1
-----------------------------------
-- !addmission 12 84
-- Levil        : !pos -87.204 3.350 12.655 256
-- Alpine Trail : !pos -13.479 -1.047 488.863 267
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.MORIMAR)

mission.reward =
{
    keyItem     = xi.ki.SAJJAKAS_PROTECTIVE_WARD,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.A_NEW_FORCE_ARISES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(165),
        },

        [xi.zone.KAMIHR_DRIFTS] =
        {
            ['Alpine_Trail'] = mission:progressEvent(46),

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:setVar(player, 'Status', 1)
                        player:setPos(306.42, -0.051, -24.974, 199, xi.zone.MOUNT_KAMIHR)
                    end
                end,
            },
        },

        [xi.zone.MOUNT_KAMIHR] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 3
                    end
                end,
            },

            onEventUpdate =
            {
                [3] = function(player, csid, option, npc)
                    if
                        csid == 3 and
                        option == 1
                    then
                        player:updateEvent(0, 2848833, 1756, 0, 0, 1, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setPos(-8.495, 0.454, 487.467, 12, xi.zone.KAMIHR_DRIFTS)
                    end
                end,
            },
        },
    },
}

return mission
