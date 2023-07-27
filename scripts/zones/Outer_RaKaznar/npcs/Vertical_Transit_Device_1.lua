-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device (1)
-- !pos -506.698 -141 -20 274
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(43, 0, 300, 0, 100, 269951, 1, 301643, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
