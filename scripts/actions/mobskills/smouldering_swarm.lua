-----------------------------------
--  Smouldering Swarm
--
--  Description: Deals Fire damage to enemies within an area of effect. Additional effect: Knockback
--  Type: Magical (Fire)
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2
    local duration = math.random(15, 90)
    local damage = mob:getWeaponDmg()

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    target:addStatusEffect(xi.effect.BURN, 10, 3, duration)
    return damage
end

return mobskillObject
