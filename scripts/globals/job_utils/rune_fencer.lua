-----------------------------------
-- Rune Fencer Job Utilities
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/ability")
require("scripts/globals/jobpoints")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.rune_fencer = xi.job_utils.rune_fencer or {}
-----------------------------------

local getMaxRunesForLevel = function(target)
    local level = 0
    local maxRuneCount = 1
    if target:getMainJob() == xi.job.RUN then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end

    if level > 35 and level < 65 then
        maxRuneCount = 2
    elseif level >= 65 then
        maxRuneCount = 3
    end

    return maxRuneCount
end

-- https://ffxiclopedia.fandom.com/wiki/Rune_Enchantment
xi.job_utils.rune_fencer.runeEnchantment = function(player, target, ability, effect)
    local runeList = player:getMaxRune()
    local runeCount = runeList.count
    local maxRunesForLevel = getMaxRunesForLevel(player)

    if runeCount >= maxRunesForLevel then
        player:removeOldestRune()
    end

    target:addStatusEffect(effect, 10, 0, 300)

    return effect
end
