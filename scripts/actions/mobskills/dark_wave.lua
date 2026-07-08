-----------------------------------
-- Dark Wave
-- Family: Bombs (Dijin)
-- Description: Inflicts Bio to targets around mob.
-- Notes: Severity of Bio effect slip damage increases at night.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local hour  = VanadielHour()
    local power = 8

    -- Note: Bio ATTP reduction seems to be static across time of day.
    local attPercReduction = 25

    if hour < 6 or hour >= 18 then
        power = 20
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, power, 3, 60, 0, attPercReduction) -- TODO: Capture power/duration

    return xi.effect.BIO
end

return mobskillObject
