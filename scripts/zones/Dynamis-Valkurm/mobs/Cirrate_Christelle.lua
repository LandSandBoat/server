-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Cirrate Christelle
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
end

return entity
