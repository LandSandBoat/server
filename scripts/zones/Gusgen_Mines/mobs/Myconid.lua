-----------------------------------
-- Area: Gusgen Mines
--  Mob: Myconid
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 683, 2, tpz.regime.type.GROUNDS)
end

return entity
