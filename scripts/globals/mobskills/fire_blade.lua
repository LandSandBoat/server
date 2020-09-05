---------------------------------------------
-- Fire Blade
-- Description: Applies Enfire and absorbs Fire damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enfire aspect adds 70+ to his melee attacks.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ENFIRE
    skill:setMsg(MobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end
