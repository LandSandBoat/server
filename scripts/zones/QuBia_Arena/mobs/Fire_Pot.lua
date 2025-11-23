-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Fire Pot
-- KSNM: E-vase-ive Action
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.FIRE_ABSORB, 100)
    mob:setMod(xi.mod.DARK_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_RES_RANK, 11)
    mob:setMod(xi.mod.ICE_RES_RANK, 11)
    mob:setMod(xi.mod.WIND_RES_RANK, 11)
    mob:setMod(xi.mod.EARTH_RES_RANK, 11)
    mob:setMod(xi.mod.THUNDER_RES_RANK, 11)
    mob:setMod(xi.mod.WATER_RES_RANK, -3)
    mob:setMod(xi.mod.FIRE_RES_RANK, -3)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

-- If Fire Pot is engaged first, despawn all other pots.
entity.onMobEngage = function(mob)
    local mobId = mob:getID()
    DespawnMob(mobId + 1) -- Ice
    DespawnMob(mobId + 2) -- Air
    DespawnMob(mobId + 3) -- Earth
    DespawnMob(mobId + 4) -- Thunder
    DespawnMob(mobId + 5) -- Water
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.BURN,
        xi.magic.spell.FLARE,
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.FIRE_IV,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
