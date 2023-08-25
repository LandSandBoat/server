-----------------------------------
-- Auroral Drape
--
-- Description: Silence and Blind Area of Effect (10.0')
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = nil
    local silenced   = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    local blinded    = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 60, 0, 60)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display silenced first, else blind
    if silenced == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.SILENCE
    elseif blinded == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BLINDNESS
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
