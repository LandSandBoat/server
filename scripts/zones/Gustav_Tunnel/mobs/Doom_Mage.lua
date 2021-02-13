-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Mage
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 765, 2, tpz.regime.type.GROUNDS)
end

return entity
