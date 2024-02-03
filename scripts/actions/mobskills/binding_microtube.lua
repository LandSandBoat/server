-----------------------------------
-- Binding Microtube
-- Deals Magic damage to target. Additional effect: Bind
-- Used by Adelheid (Trust)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)

    local dmgmod = 2.45
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.element.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
