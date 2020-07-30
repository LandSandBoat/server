---------------------------------------------
-- Cimicine Discharge
-- Reduces the attack speed of enemies within range.
-- Duration: Variable, with max of 3 min
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLOW
    local power = 1950
    local duration = math.random(60, 180)

    if not mob:hasStatusEffect(tpz.effect.HASTE) then
        mob:addStatusEffect(tpz.effect.HASTE, 1500, 0, duration)
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect

    --[[ Is there suppsoed to be a message about haste?
    local typeEffect = tpz.effect.HASTE
    skill:setMsg(MobBuffMove(mob, typeEffect, 150, 0, duration))
    return typeEffect
    ]]--
end
