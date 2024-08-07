-----------------------------------
--  Thermal Pulse
--  Family: Wamouracampa
--  Description: Deals Fire damage to enemies within area of effect. Additional effect: Blindness
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadow
--  Range: 12.5
--  Notes: Open form only.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 0 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4.5

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 90)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 100, 0, duration)

    return damage
end

return mobskillObject
