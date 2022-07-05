-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Gerlbotz
-- Standard Info NPC
-- pos -371.4615 -4.0000 -507.2594

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity