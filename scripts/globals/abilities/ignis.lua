-----------------------------------
-- Ability: Ignis
-- Increases resistance against ice and deals fire damage.
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:05
-- Duration: 5:00
-----------------------------------
-- NOTES:
-----------------------------------
-- Elemental Resistance for one Rune = Floor((49 × Level ÷ 99) + 5.5) + (2~10 Merit Points) + (1~20 Job Points)
-- Equipment with "Sword enhancement spell damage +n", such as Hollow Earring or Ayanmo Manopolas +2, does not affect the damage from this ability.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end



function onUseAbility(player,target,ability)
    local level
    local maxRuneCount
    local effect = tpz.effect.IGNIS

    if (target:getMainJob() == tpz.job.RUN) then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end
    if level < 35 then
        maxRuneCount = 1
    elseif level > 35 and level < 65 then
        maxRuneCount = 2
    elseif level >= 65 then
        maxRuneCount = 3
    end

    if target:getActiveRuneCount() == maxRuneCount then
        target:removeOldestRune()
    end

    target:addStatusEffect(tpz.effect.IGNIS,1,3,180)

    return tpz.effect.IGNIS
end
