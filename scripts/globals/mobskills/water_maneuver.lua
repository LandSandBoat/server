-----------------------------------
-- Water Maneuever
-- Description: Adds thunder maneuver to automaton
-- Notes: Used by PUP Fantoccini in ENM: "Pulling the strings"
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not mob:getPet():isAlive() then
        return 0
    elseif GetMobByID(mob:getID()+1):isAlive() and mob:getPool() == 1296 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 10
    local duration = 60
    local typeEffect = xi.effect.WATER_MANEUVER

    -- Fantoccini (ENM: Pulling the Strings)
    if mob:getPool() == 1296 then
        local pet = GetMobByID(mob:getID()+1)
        pet:addStatusEffect(typeEffect, power, 0, duration)
    else
        mob:getPet():addStatusEffect(typeEffect, power, 0, duration)
    end
    return 1
end

return mobskillObject
