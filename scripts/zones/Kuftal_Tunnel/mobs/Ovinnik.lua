-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Ovinnik
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 741, 1, tpz.regime.type.GROUNDS)
end

return entity
