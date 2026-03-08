-----------------------------------
-- Fuscous Ooze
-- Family: Slugs
-- Description: Inflicts Encumbrance and Weight.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local duration = math.random(30, 45)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, duration))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_II, 0xFFFF, 0, duration)

    -- This skill does not return a specific effect in the message.
    -- Message returns "<Slug Name> uses Fuscous Ooze" and repeats for each target hit.
    return xi.msg.basic.USES
end

return mobskillObject
