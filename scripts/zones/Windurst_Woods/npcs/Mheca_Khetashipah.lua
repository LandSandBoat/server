-----------------------------------
-- Area: Windurst Woods
--  NPC: Mheca Khetashipah
-- Type: Standard NPC
-- !pos 66.881 -6.249 185.752 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(426)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
