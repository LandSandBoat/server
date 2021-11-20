-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Oscairn
-- !pos -80.214 -0.150 30.717 257
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(525)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
