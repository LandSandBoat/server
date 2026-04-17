-----------------------------------
-- Shakeshroom
-- Family: Funguar
-- Description: Deal physical damage to a a single target. Additional Effect: Disease
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 2 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.5, 1.5, 1.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.canCrit        = true
    params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 720)
    end

    skill:setFinalAnimationSub(3)

    return info.damage
end

return mobskillObject
