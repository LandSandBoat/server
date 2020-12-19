---------------------------------------------
-- Provoke
---------------------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    target:addEnmity(mob, 1, 1800)
    skill:setMsg(tpz.msg.basic.NONE)
end
