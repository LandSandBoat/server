-----------------------------------
-- Area: Gusgen Mines
--  Mob: Gallinipper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 684, 2, tpz.regime.type.GROUNDS)
end

return entity
