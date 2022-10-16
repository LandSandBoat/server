-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Shoal Pugil
-- Note: PH for Buburimboo
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 62, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BUBURIMBOO_PH, 10, 3600) -- 1 hour minimum
end

return entity
