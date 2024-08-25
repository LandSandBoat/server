-----------------------------------
-- Tidal Slash
-- Deals water damage conal
-- Type: Magical
-- Only used when wielding a spear
-- Utsusemi/Blink absorb: 2-3 shadow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 and mob:getMainJob() == xi.job.SAM then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 3.5)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 3, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return damage
end

return mobskillObject
