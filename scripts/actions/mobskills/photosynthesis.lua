-----------------------------------
-- Photosynthesis
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Only available during daytime.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- only used during daytime
    local currentTime = VanadielHour()
    if
        not mob:hasStatusEffect(xi.effect.REGEN) and
        currentTime >= 6 and currentTime <= 18
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor(mob:getMainLvl() / 10)

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 0, 180))

    return xi.effect.REGEN
end

return mobskillObject
