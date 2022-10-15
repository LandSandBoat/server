-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Ghast
-- Note: PH for Namtar
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 805, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NAMTAR_PH, 10, 3600) -- 1 hour
end

return entity
