-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ancient Warrior
-- Mission 5-1 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
end

return entity
