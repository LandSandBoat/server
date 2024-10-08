-----------------------------------
--  Flame Blast Regular Attack
--
--  Description: Deals single target fire damage to target.
--  Type: Magical
--  Utsusemi/Blink absorb: N/A
--  Range: 18'
--  Notes: Used only by KS99 Wyrm in while flying as regular attack. Only use in a dedicated flying attack skill set.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    skill:setMsg(xi.msg.basic.HIT_DMG)

    return damage
end

return mobskillObject
