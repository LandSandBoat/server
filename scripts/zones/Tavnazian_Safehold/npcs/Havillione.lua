-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Havillione
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Alternates between 383 and 320
    player:startEvent(320)
end

return entity
