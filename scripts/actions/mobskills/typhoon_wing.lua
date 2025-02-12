-----------------------------------
--  Typhoon Wing
--
--  Description: Deals hurricane-force wind damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() + 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 60, 0, 30)

    return damage
end

return mobskillObject
