-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Engraved Tablet
-- !pos 318 -15 -581 61
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(13)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
