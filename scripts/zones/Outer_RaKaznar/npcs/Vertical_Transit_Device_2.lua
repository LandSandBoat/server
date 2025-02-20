-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device (2)
-- !pos -460 -141 26.661 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(44)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
