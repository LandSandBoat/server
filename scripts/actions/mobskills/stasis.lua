-----------------------------------
-- Stasis
-- Description: Paralyzes targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local shadows = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    -- local dmg = xi.mobskills.mobFinalAdjustments(10, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, shadows)

    mob:resetEnmity(target)

    if xi.mobskills.mobPhysicalHit(skill) then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 0, 60))

        return xi.effect.PARALYSIS
    end

    return shadows
end

return mobskillObject
