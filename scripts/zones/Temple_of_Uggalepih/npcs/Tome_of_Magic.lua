-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Tome of Magic
-- Involved In Windurst Mission 7-2 (Optional Dialogue)
-- !pos 346 0 343 159 <many>
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local cs = math.random(20, 22)
    player:startEvent(cs)
end

return entity
