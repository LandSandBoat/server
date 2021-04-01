-----------------------------------
-- Abrasive Tantara
--
-- Description: Inflicts amnesia in an area of effect
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' as well as single target outside of 10'
-- Notes: Doesn't use this if its horn is broken.  It is possible for Abrasive Tantara to miss. - See discussion
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getAnimationSub() == 1 and mob:getFamily() == 165) then -- Imps without horn
        return 1
    else
        return 0
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local message = xi.msg.basic.SKILL_MISS
    local typeEffect = xi.effect.AMNESIA
    local power = 1
    local duration = 60

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskill_object
