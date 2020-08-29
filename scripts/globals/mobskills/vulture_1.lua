---------------------------------------------
-- (Vulture 1)
-- Dummy ability used for 2hr animation.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
