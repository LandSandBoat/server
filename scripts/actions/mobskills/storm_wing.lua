-----------------------------------
--  Storm Wing
--    Mob Ability: 2432
--  Description: Deals damage within a fan-shaped area. Additional effect: Silence.
--  Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 1.5)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 3, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    return damage
end

return mobskillObject
