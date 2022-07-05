-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Lengussant
-- Standard Info NPC
-- pos 
-- event 287 288 289 290 291 295 300 304 
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