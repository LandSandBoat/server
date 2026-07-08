-----------------------------------
-- Area: Uleguerand Range
--   NM: Father Frost
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, { power = 50, origin = mob })
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onSpikesDamage = function(mob, target, damage)
    local params = {}
    params.bonusmab   = 0
    params.includemab = false

    local dmg = damage + mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    dmg       = addBonusesAbility(mob, xi.element.ICE, target, dmg, params)
    dmg       = dmg * applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
    dmg       = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.ICE, true))
    dmg       = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.ICE, true, false))
    dmg       = finalMagicNonSpellAdjustments(mob, target, xi.element.ICE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.ICE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDespawn = function(mob)
    local ph = ID.mob.SNOW_MAIDEN - 1
    DisallowRespawn(ID.mob.FATHER_FROST, true)
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(GetMobRespawnTime(ph))
end

return entity
