-----------------------------------
-- Subsonics
-- Lower defense
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_DOWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 0, 180))


        return typeEffect
end

return mobskill_object
