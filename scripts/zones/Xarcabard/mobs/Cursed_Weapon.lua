-----------------------------------
-- Area: Xarcabard
--  Mob: Cursed Weapon
-- Note: PH for Barbaric Weapon
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 52, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 53, 3, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BARBARIC_WEAPON_PH, 10, 7200) -- 2 hours
end

return entity
