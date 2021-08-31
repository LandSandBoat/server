-----------------------------------
-- Area: The Boyahda Tree
--  NPC: Mandragora Warden
-- Type: NPC
-- !pos 101.978 8.369 121.969 153
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(12)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
