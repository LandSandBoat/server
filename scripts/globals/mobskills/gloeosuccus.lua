-----------------------------------
-- Gloeosuccus
-- Enfeebling
-- Description: Slows down a single target.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 180))

    return xi.effect.SLOW
end

return mobskill_object
