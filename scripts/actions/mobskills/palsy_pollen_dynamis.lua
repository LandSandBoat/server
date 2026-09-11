-----------------------------------
-- Palsy Pollen
-- Conal paralyze and damage
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.25, 1.25, 1.25 }
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 120)
    end

    return info.damage
end

return mobskillObject
