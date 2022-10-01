-----------------------------------
-- Area: Mamook
-- Mob: Poroggo Casanova
-- ToAU Quest: Prince and the Hopper
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    for i = ID.mob.POROGGO_CASANOVA + 1, ID.mob.POROGGO_CASANOVA + 5 do
        DespawnMob(i)
    end
end

return entity
