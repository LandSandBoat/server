-----------------------------------
-- Damsel Memento
-- Recovers 5% (5,000) of his HP and removes all debuffs.
-- If Dark Ixion's horn has been broken in battle, there's a chance that it will regenerate.
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 1 or
        mob:getLocalVar('charging') == 1
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:delStatusEffectsByFlag(xi.effectFlag.WALTZABLE, false)
    mob:delStatusEffectsByFlag(xi.effectFlag.ERASABLE, false)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * 5 / 100)
end

return mobskillObject
