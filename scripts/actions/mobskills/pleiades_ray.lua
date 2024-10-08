-----------------------------------
--  Pleiades Ray
--  Description: Fires a magical ray at nearby targets. Additional effects: Paralysis + Blind + Poison + Plague + Bind + Silence + Slow
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown
--  Notes: Only used by Gurfurlur the Menacing with health below 20%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobhp = mob:getHPP()

    if mobhp <= 20 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 7

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE, { breakBind = false })
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 40, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 10, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 120)

    return damage
end

return mobskillObject
