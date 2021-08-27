-----------------------------------
-- Area: Norg
--  NPC: Vishwas
-- Type: Standard NPC
-- !pos 44.028 -7.282 13.663 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(218)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
