-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Eald'narche (Phase 1)
-- Zilart Mission 16 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    --50% fast cast, no standback
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.MDEF, 50)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 25)
    mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
    mob:addStatusEffectEx(xi.effect.ARROW_SHIELD, 0, 1, 0, 0)
    mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
    mob:setMagicCastingEnabled(false)
end

entity.onMobEngage = function(mob, target)
    -- Wait 20 seconds before casting
    mob:timer(20000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)

    GetMobByID(mob:getID() + 1):updateEnmity(target)
end

entity.onMobFight = function(mob, target)
    -- Instantly respawns orbital when they despawn
    local orbitals = { mob:getID() + 3, mob:getID() + 4 }
    xi.mob.callPets(mob, orbitals, { dieWithOwner = true, noAnimation = true })
end

return entity
