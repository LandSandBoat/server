-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (6)
-- !pos -337.826 -160 294.713 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(36)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
