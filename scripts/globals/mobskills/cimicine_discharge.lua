-----------------------------------
-- Cimicine Discharge
-- Reduces the attack speed of enemies within range.
-- Duration: Variable, with max of 3 min
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLOW
    local power = 1950
    local duration = math.random(60, 180)

    if not mob:hasStatusEffect(xi.effect.HASTE) then
        mob:addStatusEffect(xi.effect.HASTE, 1500, 0, duration)
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect

    --[[ Is there suppsoed to be a message about haste?
    local typeEffect = xi.effect.HASTE
    skill:setMsg(MobBuffMove(mob, typeEffect, 150, 0, duration))
    return typeEffect
    ]]--
end

return mobskill_object
