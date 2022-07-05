-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Linus
-- Standard Info NPC
-- pos -270.6544 -4.0000 -507.0776
-- event 267 271 275 279 280 281 282 283 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
