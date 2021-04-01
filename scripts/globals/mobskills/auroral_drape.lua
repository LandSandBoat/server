-----------------------------------
-- Auroral Drape
--
-- Description: Silence and Blind Area of Effect (10.0')
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
    local silenced = false
    local blinded = false

    silenced = MobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    blinded = MobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 60, 0, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display silenced first, else blind
    if (silenced == xi.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = xi.effect.SILENCE
    elseif (blinded == xi.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = xi.effect.BLINDNESS
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskill_object
