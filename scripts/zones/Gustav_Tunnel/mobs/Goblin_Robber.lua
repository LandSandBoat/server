-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Robber
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 764, 3, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 765, 3, tpz.regime.type.GROUNDS)
end

return entity
