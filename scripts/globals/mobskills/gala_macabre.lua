---------------------------------------------
-- Gala Macabre
-- Family: Corse
-- Description: Charms all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: N/A
-- Range: Radial
-- Notes: Only used by some notorious monsters like Xolotl and Giltine.
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
    local typeEffect = tpz.effect.CHARM_I
    local power = 0

    if (not target:isPC()) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if (msg == tpz.msg.basic.SKILL_ENFEEB_IS) then
        mob:charm(target)
    end
    skill:setMsg(msg)

    return typeEffect
end
