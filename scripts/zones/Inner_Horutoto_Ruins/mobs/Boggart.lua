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

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 650, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NOCUOUS_WEAPON_PH, 5, 3600) -- 1 hour
end

return entity
