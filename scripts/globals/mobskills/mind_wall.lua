---------------------------------------------
-- Mind Wall
--
-- Description: Activates a shield to absorb all incoming magical damage.
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 3) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)

    MobBuffMove(mob, tpz.effect.MAGIC_SHIELD, 2, 0, 30)
    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end
