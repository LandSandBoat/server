-----------------------------------
--  Reaving Wind
--    Mob Ability: 2431
--  Description: Deals damage in an area of effect. Reduces target's TP by 1000.
--  Type: Magical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown radial
--  Notes: Causes Amphipteres to enter into an aura state
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.NONE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    if target:getTP() == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        target:setTP(target:getTP() - 1000)
    end

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.NONE)

    return damage
end

return mobskillObject
