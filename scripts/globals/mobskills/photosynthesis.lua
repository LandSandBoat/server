-----------------------------------
-- Photosynthesis
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Only available during daytime.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- only used during daytime
    local currentTime = VanadielHour()
    if currentTime >= 6 and currentTime <= 18 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.min(1, math.floor(mob:getMainLvl() / 10))
    local duration = 120

    -- Sabotender have longer duration
    if mob:getFamily() ~= 178 then
        duration = 180
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 3, duration))

    return xi.effect.REGEN
end

return mobskillObject
