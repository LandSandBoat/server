-----------------------------------
-- Earth Blade
-- Description: Applies Enstone and absorbs Earth damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enstone aspect adds 70+ to his melee attacks.
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
    local typeEffect = xi.effect.ENSTONE
    skill:setMsg(MobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end

return mobskill_object
