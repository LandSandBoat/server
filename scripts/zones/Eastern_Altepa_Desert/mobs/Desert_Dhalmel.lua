-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Desert Dhalmel
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 111, 3, xi.regime.type.FIELDS)
end

return entity
