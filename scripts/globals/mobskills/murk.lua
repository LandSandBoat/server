-----------------------------------
-- Murk
--
-- Description: Slow and Weight Area of Effect (10.0')
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local slowed = false
    local weight = false

    slowed = MobStatusEffectMove(mob, target, tpz.effect.SLOW, 1250, 0, 60)
    weight = MobStatusEffectMove(mob, target, tpz.effect.WEIGHT, 40, 0, 60)

    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)

    -- display slow first, else weight
    if slowed == tpz.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = tpz.effect.SLOW
    elseif weight == tpz.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = tpz.effect.WEIGHT
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskill_object
