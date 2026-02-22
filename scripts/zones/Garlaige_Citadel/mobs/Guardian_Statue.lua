-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Guardian Statue
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.SLASH_SDT, -5000)
    mob:setMod(xi.mod.PIERCE_SDT, -5000)
    mob:setMod(xi.mod.IMPACT_SDT, -5000)
    mob:setMod(xi.mod.HTH_SDT, -5000)

    mob:setMod(xi.mod.STORETP, 250) -- 4 hits to 1k TP
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 167)
end

return entity
