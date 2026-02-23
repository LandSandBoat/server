-----------------------------------
-- Area: Ordelles Caves
--   NM: Polevik
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)

    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.SLASH_SDT, -8500)
    mob:setMod(xi.mod.PIERCE_SDT, -8500)
    mob:setMod(xi.mod.IMPACT_SDT, -8500)
    mob:setMod(xi.mod.HTH_SDT, -8500)
end

return entity
