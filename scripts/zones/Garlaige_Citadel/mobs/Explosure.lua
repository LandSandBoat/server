-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Explosure
-- Note: PH for Hazmat
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 706, 2, tpz.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HAZMAT_PH, 10, 3600) -- 1 hour
end

return entity
