-----------------------------------
--  Reactor Overheat
--  Zedi, while in Animation form 3 (Rings)
--  Blinkable 1-3 hit, addtional effect Plague on hit.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 3 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.FIRE, math.random(1, 2), xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, math.random(30, 60))

    return damage
end

return mobskillObject
