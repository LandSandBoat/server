-----------------------------------
-- Shadow Spread
-- Description: A dark shroud renders any nearby targets blinded, asleep, and cursed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = 0
    local currentMsg = nil

    local effects =
    {
        { effect = xi.effect.CURSE_I,   power = 20,  duration = 180 },
        { effect = xi.effect.SLEEP_I,   power = 1,   duration = 60 },
        { effect = xi.effect.BLINDNESS, power = 100, duration = 180 },
    }

    for _, effectData in ipairs(effects) do
        local msg = xi.mobskills.mobStatusEffectMove(mob, target, effectData.effect, effectData.power, 0, effectData.duration)
        if msg == xi.msg.basic.SKILL_ENFEEB_IS and currentMsg == nil then
            typeEffect = effectData.effect
            currentMsg = msg
        end
    end

    if currentMsg == nil then
        currentMsg = xi.msg.basic.SKILL_NO_EFFECT
    end

    skill:setMsg(currentMsg)

    return typeEffect
end

return mobskillObject
