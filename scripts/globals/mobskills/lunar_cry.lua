---------------------------------------------------
-- Lunar Cry
-- Fenrir gives accuracy and evasion down status effects to target.
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local moon = VanadielMoonPhase()
    local buffvalue = 1

    if (moon > 90) then
        buffvalue = 31
    elseif (moon > 75) then
        buffvalue = 26
    elseif (moon > 60) then
        buffvalue = 21
    elseif (moon > 40) then
        buffvalue = 16
    elseif (moon > 25) then
        buffvalue = 11
    elseif (moon > 10) then
        buffvalue = 6
    end

    target:addStatusEffect(tpz.effect.ACCURACY_DOWN, buffvalue, 0, 180)
    target:addStatusEffect(tpz.effect.EVASION_DOWN, 32-buffvalue, 0, 180)
    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_2)
    return 0

end
