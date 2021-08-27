-----------------------------------
-- Area: Windurst Waters
--  NPC: Dienger
-- Type: Melody Minstrel
-- !pos -46.448 -6.312 212.384 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(815)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
