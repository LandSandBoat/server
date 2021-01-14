-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Lizard
-- Note: PH for Nussknacker
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 817, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.NUSSKNACKER_PH, 5, 3600) -- 1 hour
end

return entity
