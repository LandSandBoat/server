-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Hover Tank
-----------------------------------
require("scripts/globals/regimes")
mixins = { require("scripts/mixins/prelate_door") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 794, 2, xi.regime.type.GROUNDS)
end

return entity
