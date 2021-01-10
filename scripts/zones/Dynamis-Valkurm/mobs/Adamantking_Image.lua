-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Adamantking Image
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
