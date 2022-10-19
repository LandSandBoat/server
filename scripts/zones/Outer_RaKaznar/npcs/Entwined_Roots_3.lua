-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (3)
-- !pos -222.581 -150 -145.591 274
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(33)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- TODO: Verify that CS moves the player
end

return entity
