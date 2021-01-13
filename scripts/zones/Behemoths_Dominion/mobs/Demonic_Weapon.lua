-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Demonic Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 102, 2, tpz.regime.type.FIELDS)
end

return entity
