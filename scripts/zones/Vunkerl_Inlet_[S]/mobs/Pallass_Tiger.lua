-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Pallas's Tiger
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = 60 })
end

entity.onMobDeath = function(mob, player, optParams)
    GetMobByID(ID.mob.PALLAS):setLocalVar('petsSpawned', 0)
end

return entity
