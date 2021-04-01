-----------------------------------
-- Winter Breeze
--
-- Description: AoE Dispel (Only removes one effect) and Stun
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
    local DISPEL = target:dispelStatusEffect()

    MobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 2)

    if (DISPEL == xi.effect.NONE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        skill:setMsg(xi.msg.basic.SKILL_ERASE)
    end

    return DISPEL
end

return mobskill_object
