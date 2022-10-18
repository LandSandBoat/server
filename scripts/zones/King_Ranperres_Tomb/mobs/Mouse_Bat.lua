-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Mouse Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 631, 1, xi.regime.type.GROUNDS)
end

return entity
