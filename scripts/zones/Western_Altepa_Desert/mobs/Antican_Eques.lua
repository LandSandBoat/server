-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Eques
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 135, 2, xi.regime.type.FIELDS)
end

return entity
