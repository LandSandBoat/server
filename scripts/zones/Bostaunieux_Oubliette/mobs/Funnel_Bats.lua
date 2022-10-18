-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Funnel Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 611, 1, xi.regime.type.GROUNDS)
end

return entity
