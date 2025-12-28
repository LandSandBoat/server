-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 2)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    -- 60% fast cast, -75% physical damage taken, 10tp/tick regain, no standback
    mob:addMod(xi.mod.UFASTCAST, 60)
    mob:addMod(xi.mod.UDMGPHYS, -7500)
    mob:addMod(xi.mod.REGAIN, 100)
    mob:setMod(xi.mod.MDEF, 50)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.TELEPORT_CD, 1)
    mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
    mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
    mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 25)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob, target)
    -- Wait 20 seconds before casting
    mob:timer(20000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

return entity
