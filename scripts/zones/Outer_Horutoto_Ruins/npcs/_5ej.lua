-----------------------------------
-- Area: Outer Horutoto Ruins
--  NPC: Ancient Magical Gizmo #6 (J out of E, F, G, H, I, J)
-- Involved In Mission: The Heart of the Matter
-----------------------------------
local func = require("scripts/zones/Outer_Horutoto_Ruins/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.gizmoOnTrigger(player, npc)

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    func.gizmoOnEventFinish(player, csid)
end

return entity
