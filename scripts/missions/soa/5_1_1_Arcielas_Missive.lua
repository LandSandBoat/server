-----------------------------------
-- Arciela's Missive
-- Seekers of Adoulin M5-1-1
-----------------------------------
-- !addmission 12 109
-- Levil           : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk  : !pos 100.580 -40.150 -63.830 257
-- Sunrise Beacon  : !pos 115.167 32 177.887 256
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local westernAdoulinID = require('scripts/zones/Western_Adoulin/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELAS_MISSIVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.HEROES_UNITE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(183, 256, 0, 3, 0, 67108863, 2811819, 4095, 4),

            ['Sunrise_Beacon'] =
            {
                onTrigger = function(player, npc)
                    if player:seenKeyItem(xi.ki.HASTILY_SCRIBBLED_NOTE) then
                        return mission:progressEvent(179, 256, 3930, 5, 5, 65306623, 1589031, 4095, 131116)
                    end
                end,
            },

            onEventFinish =
            {
                [179] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.HASTILY_SCRIBBLED_NOTE)
                        player:messageSpecial(westernAdoulinID.text.KEYITEM_LOST, xi.ki.HASTILY_SCRIBBLED_NOTE)
                    end
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(1554, 257, 2621, 2964, 0, utils.MAX_UINT32 - 806879872, utils.MAX_UINT32 - 2013266312, 3, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1554] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },
    },
}

return mission
