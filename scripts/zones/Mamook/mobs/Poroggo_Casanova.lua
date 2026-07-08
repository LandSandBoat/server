-----------------------------------
-- Area: Mamook
-- Mob: Poroggo Casanova
-- ToAU Quest: Prince and the Hopper
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    for i = ID.mob.POROGGO_CASANOVA + 1, ID.mob.POROGGO_CASANOVA + 5 do
        DespawnMob(i)
    end
end

return entity
