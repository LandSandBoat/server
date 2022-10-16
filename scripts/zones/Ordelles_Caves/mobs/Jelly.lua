-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Jelly
-- Note: PH for Agar Agar
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 659, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AGAR_AGAR_PH, 5, 3600) -- 1 hour
end

return entity
