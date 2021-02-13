-----------------------------------
-- Area: Gusgen Mines
--  Mob: Fly Agaric
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 680, 1, tpz.regime.type.GROUNDS)
end

return entity
