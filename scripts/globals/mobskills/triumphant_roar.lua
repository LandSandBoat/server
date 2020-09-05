---------------------------------------------
--  Triumphant Roar
--  Family: Gargouille
--  Description: Enhances Attack.
--  Type: Enhancing
--  Utsusemi/Blink absorb: N/A
--  Range: Self
--  Notes: Only used when standing
-----------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() ~=0) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local power = 15
    local duration = 90
    local typeEffect = tpz.effect.ATTACK_BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end
