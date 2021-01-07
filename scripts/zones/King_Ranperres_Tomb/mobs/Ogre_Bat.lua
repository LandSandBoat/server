-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Ogre Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 638, 2, tpz.regime.type.GROUNDS)
end

return entity
