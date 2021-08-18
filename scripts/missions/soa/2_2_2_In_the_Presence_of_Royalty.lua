-----------------------------------
-- In the Presence of Royalty
-- Seekers of Adoulin M2-2-2
-----------------------------------
-- !addmission 12 16
-- Ergon_Locus_3      : !pos 442.000 0.660 -224.000 263
-- Pellucid_Afflusion : !pos -175.100 1.700 387.700 263
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.IN_THE_PRESENCE_OF_ROYALTY)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_TWIN_WORLD_TREES },
}

mission.sections =
{
    -- Need the key item
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and not player:hasKeyItem(xi.ki.YORCIAS_TEAR)
        end,

        [xi.zone.YORCIA_WEALD] =
        {
            ['Harvesting_Point'] = {
                onTrade = function(player, npc, trade)
                    -- TODO: CSID for YORCIA_WEALD
                    xi.helm.onTrade(player, npc, trade, xi.helm.type.HARVESTING, nil, nil)
                    return mission:keyItem(xi.ki.YORCIAS_TEAR)
                end,
            },

            ['Ergon_Locus_3'] =
            {
                onTrigger = function(player, npc)
                    return mission:keyItem(xi.ki.YORCIAS_TEAR)
                end,
            },
        },
    },

    -- Has the key item
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and player:hasKeyItem(xi.ki.YORCIAS_TEAR)
        end,

        [xi.zone.YORCIA_WEALD] =
        {
            ['Pellucid_Afflusion'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(2)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        npcUtil.giveKeyItem(player, xi.ki.ROSULATIAS_POME)
                    end
                end,
            },
        },
    },
}

return mission
