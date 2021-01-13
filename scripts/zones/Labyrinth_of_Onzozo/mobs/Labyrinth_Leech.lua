-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Labyrinth Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 771, 1, tpz.regime.type.GROUNDS)
end

return entity
