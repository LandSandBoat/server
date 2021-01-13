-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Greatclaw
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 811, 2, tpz.regime.type.GROUNDS)
end

return entity
