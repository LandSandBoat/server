-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Goblin Bounty Hunter
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 57, 2, tpz.regime.type.FIELDS)
end

return entity
