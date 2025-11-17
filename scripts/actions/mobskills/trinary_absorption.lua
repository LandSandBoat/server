-----------------------------------
-- Trinary Absorption
-- Deals elemental damage to the target. Additional effect: Drain.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 Shadows
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:isMobType(xi.mobType.NOTORIOUS) or
        target:hasStatusEffect(xi.effect.BATTLEFIELD)
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 5, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end

return mobskillObject
