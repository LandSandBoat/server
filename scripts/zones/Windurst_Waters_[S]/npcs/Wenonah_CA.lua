-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Wenonah, C.A.
-- Type: Campaign Arbiter
-- !pos -2.175 -2 10.184 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(459)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
