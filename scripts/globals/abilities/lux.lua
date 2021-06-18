-----------------------------------
-- Ability: Lux
-- Increases resistance against darkness and deals light damage.
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:05
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local level
    local maxRuneCount
    local mainDMG      = target:getWeaponDmg()
    local mainDRank    = target:getWeaponDmgRank()
    local mainSkillLvl = target:getWeaponSkillLevel(xi.slot.MAIN)
    local finalDmg     = 0

    if (target:getMainJob() == xi.job.RUN) then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end
    if level < 35 then
        maxRuneCount = 1
    elseif level > 35 and level < 65 then
        maxRuneCount = 2
        finalDmg = finalDmg * 2
    elseif level >= 65 then
        maxRuneCount = 3
        finalDmg = finalDmg * 3
    end

    finalDmg = ((mainSkillLvl / mainDMG) * mainDRank) / maxRuneCount

    if target:getActiveRunes() > 0 and target:hasStatusEffect(xi.effect.LUX) then
        local effect = player:getStatusEffect(xi.effect.LUX)
        finalDmg = finalDmg + effect:getPower()
    end

    if target:getActiveRunes() == maxRuneCount then
        target:removeOldestRune()
    end

    target:addStatusEffect(xi.effect.LUX,finalDmg,3,180)
    printf("final damage for en effect LUX = %s", finalDmg)

    return xi.effect.LUX
end

return ability_object
