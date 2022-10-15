-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Killer Bee
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 30, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 95, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity
