-----------------------------------
-- Mending Halation
-- Causes your luopan to vanish and restores HP of party members within area of effect.
-- Obtained: Geomancer Level 75
-- Note: Heals for a fixed amount based on Luopan Level:
-- This is a light-based cure, so it can suffer Darkness day/weather penalties.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local master    = pet:getMaster()
    local hpAmount  = math.floor(7 * pet:getMainLvl())
    local hpRestore = hpAmount

    if master and master:getMerit(xi.merit.MENDING_HALATION) > 0 then
        hpRestore = hpRestore + (hpRestore * 0.05 * master:getMerit(xi.merit.MENDING_HALATION))
        if master:getMod(xi.mod.MENDING_HALATION) > 0 then
            hpRestore = hpRestore + (hpRestore * 0.04 * master:getMerit(xi.merit.MENDING_HALATION))
        end
    end

    hpRestore = utils.clamp(hpRestore, 0, target:getMaxHP())

    target:wakeUp()

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)

    if target:getID() == pet:getID() then
        hpRestore = 0
    end

    target:addHP()

    pet:timer(200, function(mobArg)
        mobArg:setHP(0)
    end)

    return hpRestore
end

return abilityObject
