-----------------------------------
-- Goblin Dice
-- Description: Slow and Silence
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local slowed   = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1800, 0, 90)
    local silenced = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 90)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    if silenced then
        return xi.effect.SILENCE
    elseif slowed then
        return xi.effect.SLOW
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS) -- no effect
    end

    return nil
end

return mobskillObject
