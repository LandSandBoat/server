-----------------------------------
-- Area: Heavens Tower
--  NPC: Mashua
-- !pos -7.399 -0.5 4.580 242
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
