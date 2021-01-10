-----------------------------------
-- Area: Fei'Yin
--  Mob: Sentient Carafe
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 718, 2, tpz.regime.type.GROUNDS)
end

return entity
