-----------------------------------
-- Area: Norg
--  NPC: Sohyon
-- Type: Standard NPC
-- !pos 47.286 -7.282 13.873 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(212)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
