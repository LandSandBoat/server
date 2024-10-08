-----------------------------------
-- Burning Blade
--
-- Description: Deals fire elemental damage. Damage varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: 1 Shadow?
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 33)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
