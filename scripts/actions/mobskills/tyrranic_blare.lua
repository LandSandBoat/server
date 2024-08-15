-----------------------------------
--  Tyrranic Blare
--
--  Description: Emits an overwhelming scream that damages nearby targets.
--  Type: Magical?
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Less than or equal to 10.0
--  Notes: Only used by Gulool Ja Ja.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 2.8)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)

    return damage
end

return mobskillObject
