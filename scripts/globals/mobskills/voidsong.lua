-----------------------------------
--  Voidsong
--
--  Description: Removes all status effects in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 20' radial
--  Notes:
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- can only used if not silenced
    if (mob:getMainJob() == xi.job.BRD and mob:hasStatusEffect(xi.effect.SILENCE) == false) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    mob:eraseAllStatusEffect()
    local count = target:dispelAllStatusEffect()
    count = count + target:eraseAllStatusEffect()

    if (count == 0) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskill_object
