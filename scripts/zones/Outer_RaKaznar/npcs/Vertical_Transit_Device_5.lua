-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device (5)
-- !pos 626.799 99 -20 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(47)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
