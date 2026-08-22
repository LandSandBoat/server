-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Poison Pukis
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setSpawnAnimation(1)
end

return entity
