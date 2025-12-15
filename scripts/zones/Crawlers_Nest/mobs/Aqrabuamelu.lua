-----------------------------------
-- Area: Crawlers' Nest
--   NM: Aqrabuamelu
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -140.000, y = -1.500, z =  209.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -188.000, y = -0.500, z =  209.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -140.000, y = -1.500, z =  209.000 },
    { x = -183.000, y = -0.900, z =  206.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -188.000, y = -0.500, z =  209.000 },
    { x = -194.000, y = -1.250, z =  215.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -183.000, y = -0.900, z =  206.000 },
    { x = -140.000, y = -1.500, z =  209.000 },
    { x = -221.000, y = -0.500, z =  205.000 },
    { x = -229.000, y = -0.500, z =  191.000 },
    { x = -245.000, y = -0.250, z =  196.000 },
    { x = -227.000, y = -0.900, z =  224.000 },
    { x = -210.000, y = -0.500, z =  232.000 },
    { x = -219.000, y = -0.500, z =  214.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -206.000, y = -0.500, z =  212.000 },
    { x = -194.000, y = -1.250, z =  215.000 }
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 50, 0, 0)
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onSpikesDamage = function(mob, target, damage)
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.ICE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.ICE, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.ICE, true, false))
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.ICE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.ICE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 238)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(7200, 7800)) -- 120 to 130 min
end

return entity
