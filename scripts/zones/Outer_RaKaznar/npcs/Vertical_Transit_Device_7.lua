-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device (7)
-- !pos 626.8 99 -20 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(49, 0, 300, 0, 100, 277675, 7, 578743, 8)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
