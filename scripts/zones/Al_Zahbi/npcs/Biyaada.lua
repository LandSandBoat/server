-----------------------------------
-- Area: Al Zahbi
--  NPC: Biyaada
-- Type: Rughadjeen's Attendant
-- !pos -65.802 -6.999 69.273 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(250)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
