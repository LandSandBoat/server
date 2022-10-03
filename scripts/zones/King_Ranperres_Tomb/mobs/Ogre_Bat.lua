-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Ogre Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 638, 2, xi.regime.type.GROUNDS)
end

return entity
