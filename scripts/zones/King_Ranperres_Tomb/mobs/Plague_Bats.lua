-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Plague Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 634, 1, xi.regime.type.GROUNDS)
end

return entity
