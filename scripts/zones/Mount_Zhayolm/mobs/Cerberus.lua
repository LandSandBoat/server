-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
---@type TMobEntity
local entity = {}

local drawInPositions =
{
    { 330.166, -23.909, -89.456 },
    { 314.186, -24.180, -89.331 },
    { 314.372, -23.985, -82.1   },
    { 321.629, -24,     -90.936 },
    { 329.969, -24,     -73.665 },
    { 322.330, -24,     -82.168 },
    { 331.026, -24,     -81.093 },
    { 321.795, -23.978, -73.724 },
}

entity.spawnPoints =
{
    { x = 310.427, y = -24.142, z = -86.671 },
    { x = 319.374, y = -24.007, z = -88.509 },
    { x = 319.599, y = -23.992, z = -82.799 },
    { x = 313.390, y = -23.871, z = -78.151 },
    { x = 318.662, y = -23.890, z = -73.773 },
    { x = 324.362, y = -24.269, z = -75.149 },
    { x = 323.935, y = -24.000, z = -80.289 },
    { x = 323.565, y = -24.000, z = -84.583 },
    { x = 323.058, y = -23.995, z = -90.231 },
    { x = 328.670, y = -23.984, z = -90.623 },
    { x = 331.835, y = -23.889, z = -89.472 },
    { x = 330.609, y = -24.054, z = -84.279 },
    { x = 330.292, y = -24.000, z = -79.809 },
    { x = 329.868, y = -24.109, z = -76.046 },
}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
    xi.mob.updateNMSpawnPoint(mob)

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)

    mob:addListener('TAKE_DAMAGE', 'CERBERUS_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        local damageAmount    = damage
        local damageThreshold = math.max(1, math.floor(mob:getMaxHP() * 0.005))

        if damageAmount < damageThreshold then
            return
        end

        local dmgPhysical = mobArg:getMod(xi.mod.UDMGPHYS)
        local dmgRanged   = mobArg:getMod(xi.mod.UDMGRANGE)
        local dmgMagical  = mobArg:getMod(xi.mod.UDMGMAGIC)
        local dmgBreath   = mobArg:getMod(xi.mod.UDMGBREATH)

        local modifierAdjustment = math.floor(damageAmount / damageThreshold) * 50

        if
            attackType == xi.attackType.PHYSICAL or
            attackType == xi.attackType.RANGED
        then
            dmgPhysical = utils.clamp(dmgPhysical - modifierAdjustment, -8500, 8500)
            dmgRanged   = utils.clamp(dmgRanged - modifierAdjustment, -8500, 8500)
            dmgMagical  = utils.clamp(dmgMagical + modifierAdjustment, -8500, 8500)
            dmgBreath   = utils.clamp(dmgBreath + modifierAdjustment, -8500, 8500)
        elseif
            attackType == xi.attackType.MAGICAL or
            attackType == xi.attackType.BREATH
        then
            dmgPhysical = utils.clamp(dmgPhysical + modifierAdjustment, -8500, 8500)
            dmgRanged   = utils.clamp(dmgRanged + modifierAdjustment, -8500, 8500)
            dmgMagical  = utils.clamp(dmgMagical - modifierAdjustment, -8500, 8500)
            dmgBreath   = utils.clamp(dmgBreath - modifierAdjustment, -8500, 8500)
        end

        mobArg:setMod(xi.mod.UDMGPHYS, dmgPhysical)
        mobArg:setMod(xi.mod.UDMGRANGE, dmgRanged)
        mobArg:setMod(xi.mod.UDMGMAGIC, dmgMagical)
        mobArg:setMod(xi.mod.UDMGBREATH, dmgBreath)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.DEF, 486)
    mob:setMod(xi.mod.ATT, 615)
    mob:setMod(xi.mod.REGAIN, 10)

    mob:setMod(xi.mod.FIRE_RES_RANK, 7)
    mob:setMod(xi.mod.ICE_RES_RANK, 7)
    mob:setMod(xi.mod.WIND_RES_RANK, 7)
    mob:setMod(xi.mod.EARTH_RES_RANK, 7)
    mob:setMod(xi.mod.THUNDER_RES_RANK, 7)
    mob:setMod(xi.mod.WATER_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_RES_RANK, 7)
    mob:setMod(xi.mod.DARK_RES_RANK, 7)

    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMod(xi.mod.GRAVITY_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.POISON_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)

    mob:setMod(xi.mod.UDMGBREATH, -1250)
    mob:setMod(xi.mod.UDMGMAGIC, -1250)

    mob:setMod(xi.mod.CURSE_MEVA, 1000)
end

entity.onMobRoam = function(mob)
    if mob:isFollowingPath() then
        return
    end

    local currentTime = GetSystemTime()
    if currentTime < mob:getLocalVar('roarTimer') then
        return
    end

    mob:useMobAbility(xi.mobSkill.ROAR_CERBERUS)
    mob:setLocalVar('roarTimer', currentTime + math.random(150, 210))
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 10)
    else
        mob:setMod(xi.mod.REGAIN, 60)
    end

    if
        target:getZPos() <= -70 and
        target:getXPos() >= 310 and
        utils.sameSideOfLine({ { 335, -92 }, { 332, -94 } }, target:getPos(), mob:getSpawnPos())
    then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        return
    end

    mob:setMobMod(xi.mobMod.NO_MOVE, 1)

    local pos = utils.randomEntry(drawInPositions)
    utils.drawIn(target, { position = { pos[1], pos[2], pos[3], target:getRotPos() }, wait = 2 })
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.ULULATION,
        xi.mobSkill.MAGMA_HOPLON,
    }

    if target:isInfront(mob, 128) then
        table.insert(skillList, xi.mobSkill.LAVA_SPIT)
        table.insert(skillList, xi.mobSkill.SULFUROUS_BREATH)
    end

    if target:isBehind(mob, 128) then
        table.insert(skillList, xi.mobSkill.SCORCHING_LASH)
    end

    if mob:getHPP() < 25 then
        table.insert(skillList, xi.mobSkill.GATES_OF_HADES)
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDisengage = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.CERBERUS_MUZZLER)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
end

return entity
