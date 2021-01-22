-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Kuftal Delver
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 742, 1, tpz.regime.type.GROUNDS)
end

return entity
