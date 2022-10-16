-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Robber Crab
-- Note: PH for Aquarius
-----------------------------------
local ID = require("scripts/zones/The_Boyahda_Tree/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 720, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AQUARIUS_PH, 5, 1) -- can repop instantly
end

return entity
