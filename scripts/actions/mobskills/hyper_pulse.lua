-----------------------------------
--  Hyper_Pulse
--
--  Description:  300 magic damage, Gravity and short Bind, wipes Utsusemi
--  Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1.5, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK, { breakBind = false })
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 4)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 30)

    return damage
end

return mobskillObject
