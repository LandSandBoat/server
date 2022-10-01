-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Fly Agaric
-- Note: PH for Donggu
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 656, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DONGGU_PH, 10, 1) -- Window opens immediately from its last Time of Death.
end

return entity
