-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Goblin Tinkerer
-----------------------------------
require("scripts/globals/regimes")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 84, 2, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

return entity
