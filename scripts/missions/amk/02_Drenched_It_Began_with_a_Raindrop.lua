-----------------------------------
-- Drenched! It Began with a Raindrop
-- A Moogle Kupo d'Etat M2
-----------------------------------
-- !addmission 10 1
-----------------------------------
require("scripts/globals/items")
require('scripts/globals/missions')
require('scripts/globals/moghouse')
require("scripts/globals/npc_util")
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO },
}

-- Since there are so many zones with interactions:
-- Populate each by hand
mission.sections = {}
mission.sections[1] = {} -- REMEMBER: Lua is 1-indexed!

mission.sections[1].check = function(player, currentMission, missionStatus, vars)
    return currentMission == mission.missionId and
           xi.moghouse.isInMogHouseInHomeNation(player) and
end

local moogleTriggerEvent =
{
    ['Moogle'] =
    {
        onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, {
                    xi.items.ORCISH_PLATE_ARMOR,
                    xi.items.QUADAV_BACKSCALE,
                    xi.items.YAGUDO_CAULK
                })
            then
                player:progressEvent(30024)
            end
        end,
    },

    onEventFinish =
    {
        [30024] = function(player, csid, option, npc)
            mission:complete(player)
        end,
    },
}

for i, zoneId in ipairs(xi.moghouse.moghouseZones) do
    mission.sections[1][zoneId] = moogleTriggerEvent
end

return mission
