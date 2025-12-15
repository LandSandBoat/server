-----------------------------------
-- Roller Chain
-- Only used by Ramparts when its door is closed
-- Description: Single target Bind, Silence, Amnesia.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' Aoe
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 3000, 0, 30)

    return damage
end

return mobskillObject
