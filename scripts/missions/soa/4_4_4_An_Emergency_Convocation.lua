-----------------------------------
-- An Emergency Convocation
-- Seekers of Adoulin M4-4-4
-----------------------------------
-- !addmission 12 98
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.AN_EMERGENCY_CONVOCATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.BALAMOR_THE_DEATHBORNE_XOL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 5, 975, 3551, 1487, 975, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if not mission:getMustZone(player) then
                        return mission:progressEvent(1535, 0, 16744959, utils.MAX_UINT32 - 1, 0, 4063, 1999, 1985, 0)
                    else
                        return mission:progressEvent(1542, 257, 0, 5, 0, 4061, 1999, 1999, 0)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return 1551
                    elseif missionStatus == 2 then
                        return 1552
                    end
                end,
            },

            onEventUpdate =
            {
                [1551] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(0, 0, 1, 975, 4063, 1999, 1999, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [1535] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(91.751, -40, -63.998, 127, xi.zone.EASTERN_ADOULIN)
                end,

                [1551] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(91.751, -40, -63.998, 127, xi.zone.EASTERN_ADOULIN)
                end,

                [1552] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.BALAMOR_THE_DEATHBORNE_XOL, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
