-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (5)
-- !pos -460 -141 -66.807 274
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(35)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- TODO: Verify that CS moves the player
end

return entity
