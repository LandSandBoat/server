-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Boggart
-- Note: Place holder Nocuous Weapon
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 650, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.NOCUOUS_WEAPON_PH, 5, 3600) -- 1 hour
end

return entity
