-----------------------------------
-- Area: Gusgen Mines
--  Mob: Mauthe Doog
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 682, 3, xi.regime.type.GROUNDS)
end

return entity
