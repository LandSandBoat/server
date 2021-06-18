-----------------------------------
-- Ability: Tenebrae
-- Increases resistance against light and deals darkness damage.
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:05
-- Duration: 5:00
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
    local mainDMG      = target:getWeaponDmg()
    local mainDRank    = target:getWeaponDmgRank()
    local mainSkillLvl = target:getWeaponSkillLevel(tpz.slot.MAIN)
    local finalDmg     = 0



    if (target:getMainJob() == tpz.job.RUN) then
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

    if target:getActiveRunes() > 0 and target:hasStatusEffect(tpz.effect.TENEBRAE) then
        local effect = player:getStatusEffect(tpz.effect.TENEBRAE)
        finalDmg = finalDmg + effect:getPower()
    end

    if target:getActiveRunes() == maxRuneCount then
        target:removeOldestRune()
    end

    target:addStatusEffect(tpz.effect.TENEBRAE,finalDmg,3,180)
    printf("final damage for en effect TENEBRAE = %s", finalDmg)

    return tpz.effect.TENEBRAE
end
