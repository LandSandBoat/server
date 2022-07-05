-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Cordaurie
-- Standard Info NPC
-- pos -253.4521 -4.0000 -506.1546
-- event 287 291 292 293 294 295 300 304 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(287)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
