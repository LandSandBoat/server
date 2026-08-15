-----------------------------------
-- Area: Batallia Downs
--  Mob: Sturmtiger
-- Involved in Quest: Chasing Quotas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.ATT, 360)
end

return entity
