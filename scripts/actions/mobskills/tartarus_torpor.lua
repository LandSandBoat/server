-----------------------------------
-- Tartarus Torpor
-- Family: Humanoid Staff Weaponskill
-- Description: Puts enemies within the area of effect to sleep and lowers their magic defense and magic evasion. Duration of effect varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 60, 180)

    -- params.str_wSC = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 10, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_EVASION_DOWN, 10, 0, duration)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration))

    return xi.effect.SLEEP_I
end

return mobskillObject
