-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Demonic Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 766, 2, tpz.regime.type.GROUNDS)
end

return entity
