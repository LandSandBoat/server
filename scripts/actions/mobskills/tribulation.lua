-----------------------------------
--  Tribulation
--
--  Description: Inflicts Bio and blinds all targets in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: AoE
--  Notes: Bio effect can take away up to 39/tick.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = nil
    local blinded    = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120)
    local bio        = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 39, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display blind first, else bio
    if blinded == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BLINDNESS
    elseif bio == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.BIO
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
