-----------------------------------
--  Decussate
--
--  Description: Performs a cross attack on nearby targets.
--  Type: Magical
--  Utsusemi/Blink absorb: 2-3 shadows?
--  Range: Less than or equal to 10.0
--  Notes: Unlocked at 20% hp
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() > 20 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.EARTH, 1.2, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, math.random(2, 3))

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)

    return damage
end

return mobskillObject
