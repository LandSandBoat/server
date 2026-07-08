-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Seeker
-- Mission 2-3 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 50)
end

return entity
