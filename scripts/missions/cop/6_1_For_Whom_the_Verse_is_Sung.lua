-----------------------------------
-- For Whom the Verse is Sung
-- Promathia 6-1
-----------------------------------
-- !addmission 6 578
-- Pherimociel   : !pos -31.627 1.002 67.956 243
-- Marble Bridge : !pos -96.6 -0.2 92.3 244
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Pherimociel'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(10046)
                    elseif missionStatus == 1 then
                        return mission:event(10052):replaceDefault()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 10047
                    end
                end,
            },

            onEventFinish =
            {
                [10046] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [10047] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s1'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(10011)
                    end
                end,
            },

            onEventFinish =
            {
                [10011] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },
    },
}

return mission
