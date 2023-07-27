-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Tome of Magic
-- Involved In Windurst Mission 7-2 (Optional Dialogue)
-- !pos 346 0 343 159 <many>
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cs = math.random(20, 22)
    player:startEvent(cs)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
