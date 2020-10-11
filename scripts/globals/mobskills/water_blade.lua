---------------------------------------------
-- Water Blade
-- Description: Applies Enwater and absorbs Water damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enwater aspect adds 70+ to his melee attacks.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ENWATER
    skill:setMsg(MobBuffMove(mob, typeEffect, 65, 0, 60))
    return typeEffect
end
