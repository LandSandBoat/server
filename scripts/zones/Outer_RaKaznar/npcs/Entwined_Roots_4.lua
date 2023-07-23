-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (4)
-- !pos -337.826 -160 294.713 274
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(34)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
