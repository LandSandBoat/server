-----------------------------------
-- Tending Aged Wounds
-- Promathia 3-4
-----------------------------------
-- !addmission 6 350
-- Cid                   : !pos -12 -12 1 237
-- Door: Neptune's Spire : !pos 35 0 -15 245
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] = mission:progressEvent(862):oncePerZone(),
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6tc'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(22)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 0 then
                        return 70
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [70] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },
    },
}

return mission
