-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Goobbue
-- Note: PH for Jolly Green
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 60, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.JOLLY_GREEN_PH, 5, 1) -- 1 second / no cooldown
end

return entity
