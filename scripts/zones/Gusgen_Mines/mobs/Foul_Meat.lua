-----------------------------------
-- Area: Gusgen Mines
--  Mob: Foul Meat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(64800, 86400)) -- 18 to 24 hours
end

return entity
