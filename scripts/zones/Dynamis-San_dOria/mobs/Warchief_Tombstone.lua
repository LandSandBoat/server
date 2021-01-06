-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Warchief Tombstone
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
