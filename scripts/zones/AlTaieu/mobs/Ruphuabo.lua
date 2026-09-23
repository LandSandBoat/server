-----------------------------------
-- Area: Al'Taieu
--  Mob: Ru'phuabo
-- Jailor of Love Pet version
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, GetMobByID(ID.mob.JAILER_OF_LOVE):getTargID())
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
end

return entity
