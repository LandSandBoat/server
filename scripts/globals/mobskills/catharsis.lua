---------------------------------------------
-- Catharsis
-- Description: Restores HP.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (target:getCurrentRegion() == tpz.region.TAVNAZIANARCH) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local potency = skill:getParam()

    if (potency == 0) then
        potency = 12
    end

    potency = potency - math.random(0, potency/4)
    skill:setMsg(tpz.msg.basic.SELF_HEAL)

    return MobHealMove(mob, mob:getMaxHP() * potency / 100)
end
