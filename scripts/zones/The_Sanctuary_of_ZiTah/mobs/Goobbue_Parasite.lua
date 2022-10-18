-----------------------------------
-- Area: The Sanctuary of ZiTah
--  Mob: Goobbue Parasite
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 116, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 117, 2, xi.regime.type.FIELDS)
end

return entity
