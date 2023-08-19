-----------------------------------
-- Echo Drops - Removes Silence.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- TODO: verify no effect messaging
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.SILENCE) then
        target:delStatusEffect(xi.effect.SILENCE)
        return xi.effect.SILENCE
    end

    skill:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    return xi.effect.NONE
end

return mobskillObject
