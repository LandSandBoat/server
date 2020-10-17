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
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:useMobAbility(mob:getMobMod(tpz.mobMod.TELEPORT_END))
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
