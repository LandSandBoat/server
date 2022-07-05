-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Fina
-- Race Attendant (Green)
-- POS: -366.0453 4.0000 -532.8646

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(341)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity