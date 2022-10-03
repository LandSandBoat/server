-----------------------------------
-- Area: Quicksand Caves
--  Mob: Helm Beetle
-- Note: PH for Diamond Daig
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 813, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DIAMOND_DAIG_PH, 10, 3600) -- 1 hour
end

return entity
