-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Goblin Bounty Hunter
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 62, 2, xi.regime.type.FIELDS)
end

return entity
