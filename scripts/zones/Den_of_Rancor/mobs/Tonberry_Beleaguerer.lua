-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Beleaguerer
-- Note: PH for Bistre-hearted Malberry
-----------------------------------
mixins = { require("scripts/mixins/families/tonberry") }
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BISTRE_HEARTED_MALBERRY_PH, 10, 3600) -- 1 hour
end

return entity
