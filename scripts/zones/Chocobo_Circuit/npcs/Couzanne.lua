-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Couzanne
-- Grandstand Exit
-- pos -110.9048 -14.5000 -131.5597

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(332)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity