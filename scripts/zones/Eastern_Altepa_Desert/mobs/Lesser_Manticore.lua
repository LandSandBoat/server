-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Lesser Manticore
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 112, 4, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 113, 4, xi.regime.type.FIELDS)
end

return entity
