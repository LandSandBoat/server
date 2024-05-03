-----------------------------------
-- Drenched! It Began with a Raindrop
-- A Moogle Kupo d'Etat M2
-- !addmission 10 1
-- ORCISH_PLATE_ARMOR : !additem 2757
-- QUADAV_BACKSCALE   : !additem 2758
-- YAGUDO_CAULK       : !additem 2759
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
        xi.moghouse.isInMogHouseInHomeNation(player)
end

local moogleTriggerEvent =
{
    ['Moogle'] =
    {
        onTrade = function(player, npc, trade)
            if
                npcUtil.tradeHasExactly(trade, { xi.item.ORCISH_PLATE_ARMOR, xi.item.QUADAV_BACKSCALE, xi.item.YAGUDO_CAULK })
            then
                return mission:progressEvent(30024)
            end
        end,
    },

    onEventFinish =
    {
        [30024] = function(player, csid, option, npc)
            if mission:complete(player) then
                player:confirmTrade()
            end
        end,
    },
}

for i, zoneId in ipairs(xi.moghouse.moghouseZones) do
    mission.sections[1][zoneId] = moogleTriggerEvent
end

return mission
