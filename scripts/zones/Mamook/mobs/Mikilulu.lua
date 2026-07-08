-----------------------------------
-- Area: Mamook
-- Mob: Mikilulu
-- ToAU Quest: Prince and the Hopper
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
end

return entity
