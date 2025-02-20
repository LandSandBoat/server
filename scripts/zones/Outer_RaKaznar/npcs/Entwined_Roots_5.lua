-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (5)
-- !pos -460 -141 -66.807 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(35)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
