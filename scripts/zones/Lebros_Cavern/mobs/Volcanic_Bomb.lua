-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Volcanic Bomb
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, 33)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
end

return entity
