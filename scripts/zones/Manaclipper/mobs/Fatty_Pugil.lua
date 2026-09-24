-----------------------------------
-- Area: Manaclipper
--  Mob: Fatty Pugil
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, math.randomInt(222, 312))
end

return entity
