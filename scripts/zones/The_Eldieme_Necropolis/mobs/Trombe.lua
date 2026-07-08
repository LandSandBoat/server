-----------------------------------
-- Area: The Eldieme Necropolis
--  MOB:  Trombe
-- Involved in Quest: A New Dawn (BST AF3)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 800)
end

return entity
