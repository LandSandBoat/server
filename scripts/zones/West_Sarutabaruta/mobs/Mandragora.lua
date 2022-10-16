-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Mandragora
-- Note: PH for Tom Tit Tat
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 26, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TOM_TIT_TAT_PH, 7, math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
