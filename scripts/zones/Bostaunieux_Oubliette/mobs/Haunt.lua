-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Haunt
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 612, 2, xi.regime.type.GROUNDS)
end

return entity
