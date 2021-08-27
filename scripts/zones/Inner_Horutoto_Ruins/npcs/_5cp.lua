-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: _5cp (Magical Gizmo) #1
-- Involved In Mission: The Horutoto Ruins Experiment
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Outside of Windurst Mission 1-1, these Gizmos give no responde or text.
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
