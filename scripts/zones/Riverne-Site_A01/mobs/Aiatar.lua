-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
