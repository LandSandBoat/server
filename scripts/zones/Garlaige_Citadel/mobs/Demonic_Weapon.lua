-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Demonic Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 705, 1, xi.regime.type.GROUNDS)
end

return entity
