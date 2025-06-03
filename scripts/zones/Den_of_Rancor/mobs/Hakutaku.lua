-----------------------------------
-- Area: Den of Rancor
--  Mob: Hakutaku
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMod(xi.mod.SILENCE_MEVA, 200)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
