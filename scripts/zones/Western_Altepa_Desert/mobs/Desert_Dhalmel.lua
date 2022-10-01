-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Dhalmel
-- Note: Place holder for Celphie
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 135, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CELPHIE_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
