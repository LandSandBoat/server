-----------------------------------
-- Damsel Memento
-- Recovers 5% (5,000) of his HP and removes all debuffs.
-- If Dark Ixion's horn has been broken in battle, there's a chance that it will regenerate. This is handled in xi.darkixion.onMobWeaponSkill since it involves an animation sequence
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- since we have no mobskill weighting, randomize allowing the skill to emulate this behavior
    if math.random(1, 100) <= 5 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:delStatusEffectsByFlag(xi.effectFlag.WALTZABLE, false)
    mob:delStatusEffectsByFlag(xi.effectFlag.ERASABLE, false)
    skill:setMsg(xi.msg.basic.SELF_HEAL_NOHP)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * 5 / 100)
end

return mobskillObject
