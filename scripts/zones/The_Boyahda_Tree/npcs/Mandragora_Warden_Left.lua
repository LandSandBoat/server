-----------------------------------
-- Area: The Boyahda Tree
--  NPC: Mandragora Warden
-- Type: NPC
-- !pos 99.068 8.548 122.514 153
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(11)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
