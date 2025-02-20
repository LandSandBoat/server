-----------------------------------
-- Area: Castle Oztroja [S]
--  Mob: Yagudo Knight Templar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
