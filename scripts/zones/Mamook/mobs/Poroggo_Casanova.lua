-----------------------------------
-- Area: Mamook
-- Mob: Poroggo Casanova
-- ToAU Quest: Prince and the Hopper
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
mixins = { require('scripts/mixins/families/poroggo') }
-----------------------------------
---@type TMobEntity
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
