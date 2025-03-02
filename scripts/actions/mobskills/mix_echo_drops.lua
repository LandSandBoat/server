-----------------------------------
-- Echo Drops - Removes Silence.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- TODO: verify no effect messaging
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.SILENCE) then
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
        target:delStatusEffect(xi.effect.SILENCE)
        return xi.effect.SILENCE
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT)
    end
end

return mobskillObject
