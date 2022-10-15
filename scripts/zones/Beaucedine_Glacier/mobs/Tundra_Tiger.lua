-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Tundra Tiger
-- Note: PH for Nue, Kirata
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 46, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 47, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.KIRATA_PH, 7, 3600) -- 1 hour minimum
    xi.mob.phOnDespawn(mob, ID.mob.NUE_PH, 7, 3600) -- 1 hour minimum
end

return entity
