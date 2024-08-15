-----------------------------------
--  Bloody Beak
--    Mob Ability: 2428
--  Description: Steals HP from targets within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores Utsusemi
--  Range: 5'
--  Notes: Seems to be magical-based Drain.
--    Witnessed Paladin taking lower damage from it than Ninja with Shell only.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, damage))

    return damage
end

return mobskillObject
