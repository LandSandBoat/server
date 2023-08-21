-----------------------------------
-- Studying Up
-- Seekers of Adoulin M4-2-2
-----------------------------------
-- !addmission 12 79
-- Levil        : !pos -87.204 3.350 12.655 256
-- Alpine Trail : !pos -13.479 -1.047 488.863 267
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.STUDYING_UP)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.A_VOW_OF_TRUTH },
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
            ['Alpine_Trail'] = mission:progressEvent(45),

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
                [45] = function(player, csid, option, npc)
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
                        return 2
                    end
                end,
            },

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(10, 0, 1756, 740, 0, 1, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(-8.495, 0.454, 487.467, 12, xi.zone.KAMIHR_DRIFTS)
                end,
            },
        },
    },
}

return mission
