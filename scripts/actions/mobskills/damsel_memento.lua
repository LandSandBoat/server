-----------------------------------
-- Damsel Memento
-- Family: Monoceros (Dark Ixion)
-- Description: Recovers 5% (5,000) of his HP and removes all debuffs.
-- Notes: If Dark Ixion's horn has been broken in battle, there's a chance that it will regenerate. This is handled in xi.darkixion.onMobWeaponSkill since it involves an animation sequence
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Since we have no mobskill weighting, randomize allowing the skill to emulate this behavior
    if math.randomInt(1, 100) <= 5 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.primaryMessage = xi.msg.basic.SELF_HEAL_NOHP
    params.baseHeal       = mob:getMaxHP()
    params.fTP =
    {
        -- TODO: Does it scale with TP?
        { tp = 1000, modifier = 0.05 },
        { tp = 2000, modifier = 0.05 },
        { tp = 3000, modifier = 0.05 },
    }

    mob:delStatusEffectsByFlag(xi.effectFlag.WALTZABLE, false)
    mob:delStatusEffectsByFlag(xi.effectFlag.ERASABLE, false)

    return xi.mobskills.mobHealMove(mob, target, skill, action, params)
end

return mobskillObject
