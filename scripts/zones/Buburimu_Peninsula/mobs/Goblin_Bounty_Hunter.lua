-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Goblin Bounty Hunter
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 62, 2, tpz.regime.type.FIELDS)
end

return entity
