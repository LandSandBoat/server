-----------------------------------
-- Area: Port Bastok
--  NPC: Kachada
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Currently selecting option 1 will result in a hard lock of the player requiring them to force quit the client.
    -- This likely needs special handling in the core.
    -- player:startEvent(96)--, 0, 0, 0, 0, 0, -1, 2)
end

return entity
