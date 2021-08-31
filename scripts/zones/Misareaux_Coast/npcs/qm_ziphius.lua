-----------------------------------
-- Area: Misareaux_Coast
--  NPC: ??? (Spawn Ziphius)
-- QM positions:
-- !pos 76.000,-16.000,534.000 25
-- !pos 102.500,-16.000,525.000 25
-- !pos 144.500,-16.000,520.000 25
-- !pos 184.500,-16.000,517.500 25
-- !pos 207.000,-16.000,479.000 25
-- !pos 253.000,-16.000,411.500 25
-----------------------------------
local MISAREAUX_COAST = require("scripts/zones/Misareaux_Coast/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    MISAREAUX_COAST.ziphiusOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    MISAREAUX_COAST.ziphiusOnTrigger(player, npc)
end
return entity
