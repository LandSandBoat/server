-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spartoi Sorcerer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 638, 1, xi.regime.type.GROUNDS)
end

return entity
