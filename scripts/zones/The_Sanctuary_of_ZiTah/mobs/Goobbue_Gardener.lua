-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Goobbue Gardener
-- Note: PH for Keeper of Halidom
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 114, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.KEEPER_OF_HALIDOM_PH, 10, 7200) -- 2 hours
end

return entity
