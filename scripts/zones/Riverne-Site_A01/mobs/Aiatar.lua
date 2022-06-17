-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    UpdateNMSpawnPoint(mob:getID())
end