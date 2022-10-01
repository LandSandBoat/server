-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spartoi Warrior
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 637, 1, xi.regime.type.GROUNDS)
end

return entity
