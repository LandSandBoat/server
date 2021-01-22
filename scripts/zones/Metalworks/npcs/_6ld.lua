-----------------------------------
-- Area: Metalworks
-- Door: _6ld (President's Office)
-- !pos 92 -19 0.1 237
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS and player:hasKeyItem(tpz.ki.SHADOW_FRAGMENT)) then
        player:startEvent(603)
    else
        player:startEvent(604)
    end

    return 1

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 603) then
        finishMissionTimeline(player, 1, csid, option)
    end

end

return entity
