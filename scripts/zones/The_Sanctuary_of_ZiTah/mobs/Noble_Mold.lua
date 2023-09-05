-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Noble Mold
-----------------------------------
require("scripts/globals/regimes")
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 115, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 116, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(ID.mob.NOBLE_MOLD, true)
    DisallowRespawn(ID.mob.NOBLE_MOLD_PH, false)
    GetMobByID(ID.mob.NOBLE_MOLD_PH):setRespawnTime(GetMobRespawnTime(ID.mob.NOBLE_MOLD_PH))
end

return entity
