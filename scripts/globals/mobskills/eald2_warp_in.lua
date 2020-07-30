---------------------------------------------
-- Eald2 Warp In
-- Begin Eald'Narche ZM16 (phase 2) teleport
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    mob:useMobAbility(989)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
