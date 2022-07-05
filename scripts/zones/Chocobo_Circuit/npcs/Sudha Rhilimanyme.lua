-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Sudha Rhilimanyme
-- Standard Info NPC
-- pos 
-- event 267 271 272 273 274 275 283
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