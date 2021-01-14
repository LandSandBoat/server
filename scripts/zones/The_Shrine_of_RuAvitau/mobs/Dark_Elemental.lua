-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Dark Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 750, 1, tpz.regime.type.GROUNDS)
end

return entity
