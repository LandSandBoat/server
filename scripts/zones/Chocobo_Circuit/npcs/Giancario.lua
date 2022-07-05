-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Giancario
-- Standard Info NPC
-- pos 
-- event 212 213 214 215 228 229 230 231
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