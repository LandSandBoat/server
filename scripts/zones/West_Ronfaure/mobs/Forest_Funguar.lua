-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Funguar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

return entity
