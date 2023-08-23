-----------------------------------
-- Undying Light
-- Seekers of Adoulin M5-5
-----------------------------------
-- !addmission 12 125
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.UNDYING_LIGHT)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_WITHIN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- TODO: This event does not occur on retail if warping from Ceizak to
                    -- Adoulin, and only occurs if they enter through the gate.
                    if
                        prevZone == xi.zone.CEIZAK_BATTLEGROUNDS and
                        mission:getVar(player, 'Status') == 0
                    then
                        return 182
                    end
                end,
            },

            onEventUpdate =
            {
                [182] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(5, 0, utils.MAX_UINT32 - 1, 975, 4063, 1487, 1999, 4)
                    elseif option == 9 then
                        player:updateEvent(0, 0, 1, 0, 0, 0, 1107628388, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [182] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(1547, 0, 23, 2964, 0, 33554431, 138785268, 3967, 0)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 1549
                    end
                end,
            },

            onEventFinish =
            {
                [1547] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:setPos(91.751, -40, -63.998, 127, xi.zone.EASTERN_ADOULIN)
                end,

                [1549] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_WITHIN, 'Timer', VanadielUniqueDay() + 1)

                        -- NOTE: Since The Light Within is not completed at the end of its events, start the status at 1, and then reset it to
                        -- 0 once the reward ring has been obtained.

                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_WITHIN, 'Status', 1)
                    end
                end,
            },
        },
    },
}

return mission
