-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Warchief Tombstone
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
