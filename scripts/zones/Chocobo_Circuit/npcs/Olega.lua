-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Olega
-- Standard Info NPC
-- pos -264.8404 -4.0000 -506.2439
-- event 267 271 275 279 283 284 285 286 
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
