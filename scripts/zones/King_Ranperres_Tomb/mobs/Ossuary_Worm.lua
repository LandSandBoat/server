-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Ossuary Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 636, 1, xi.regime.type.GROUNDS)
end

return entity
