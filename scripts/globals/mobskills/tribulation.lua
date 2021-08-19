-----------------------------------
--  Tribulation
--
--  Description: Inflicts Bio and blinds all targets in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: AoE
--  Notes: Bio effect can take away up to 39/tick.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local blinded = false
    local bio = false
    local typeEffect = nil

    blinded = MobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120)
    bio = MobStatusEffectMove(mob, target, xi.effect.BIO, 39, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display blind first, else bio
    if (blinded == xi.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = xi.effect.BLINDNESS
    elseif (bio == xi.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = xi.effect.BIO
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskill_object
