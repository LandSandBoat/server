-----------------------------------
--  Crystal Weapon
--
--  Description: Invokes the power of a crystal to deal magical damage of a random element to a single target.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown
--  Notes: Can be Fire, Earth, Wind, or Water element.  Functions even at a distance (outside of melee range).
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage     = mob:getWeaponDmg() * 5

    -- Choose element and damage type
    local possibleElement = { xi.element.FIRE, xi.element.EARTH, xi.element.WIND, xi.element.WATER }
    local skillElement    = possibleElement[math.random(1, 4)]
    local damageType      = xi.damageType.ELEMENTAL + skillElement

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, skillElement, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, damageType, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, damageType)

    return damage
end

return mobskillObject
