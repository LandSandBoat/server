-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spartoi Sorcerer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 638, 1, tpz.regime.type.GROUNDS)
end

return entity
