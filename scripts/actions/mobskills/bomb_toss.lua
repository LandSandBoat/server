-----------------------------------
-- Bomb Toss
-- Throws a bomb at an enemy.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.baseDamage   = mob:getWeaponDmg()
    params.fTP          = 3
    params.element      = xi.element.FIRE
    params.damageVaries = { 1.0, 1.0, 1.0 }
    params.ignoreResist = false

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
