-----------------------------------
-- Area: Lebros Cavern (Lebros Supplies)
--  Mob: Crimson Eruca
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMaxHP(mob:getMaxHP() * 5.25)
    mob:setHP(mob:getMaxHP())
end

return entity
