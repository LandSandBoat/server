-----------------------------------
-- The Tomatoes of Wrath
-- Seekers of Adoulin M4-4-2
-----------------------------------
-- !addmission 12 95
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-- Chalvava       : !pos -318.000 -1.000 -318.000 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_TOMATOES_OF_WRATH)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.A_GRAVE_MISTAKE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 255, 255, 255, 255, 255, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] = mission:progressEvent(1533, 257, 935, 127, 0, 4063, 1999, 1989, 0),

            onEventFinish =
            {
                [1533] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(370, 258, 3033627, 1756, utils.MAX_UINT32 - 6266, 20780, 121, 554049, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [370] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },
    },
}

return mission
