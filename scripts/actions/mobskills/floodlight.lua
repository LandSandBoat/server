-----------------------------------
-- Floodlight
-- Description:  ~300 magic damage, Flash, Blind and Silence, ignores Utsusemi
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 200, 3, 20)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end

return mobskillObject
