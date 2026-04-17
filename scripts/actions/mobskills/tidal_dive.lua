-----------------------------------
-- Tidal Dive
-- Family: Phuabo
-- Description: Dives at nearby targets. Additional Effect: Bind, Weight
-- Notes: Only used over deep water.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local terrain = mob:getZone():getTerrainType(mob:getPos())
    if
        terrain ~= xi.terrain.DEEP_WATER and
        terrain ~= xi.terrain.SHALLOW_WATER -- Al'Taieu is only made of shallow water blocks
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING -- TODO: Capture damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 120)
    end

    return info.damage
end

return mobskillObject
