-----------------------------------
-- Area: Den of Rancor
--  Mob: Tormentor
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 802, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 803, 1, tpz.regime.type.GROUNDS)
end

return entity
