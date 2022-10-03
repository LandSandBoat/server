-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Greatclaw
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 811, 2, xi.regime.type.GROUNDS)
end

return entity
