-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Khea Mhyyih
-- !pos -53.927 -4.499 56.215 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(428)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
