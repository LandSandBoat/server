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

local getRUNLevel = function(target)
    local level = 0
    if target:getMainJob() == xi.job.RUN then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end
    return level
end

local getMaxRunesForLevel = function(level)
    local maxRuneCount = 1
    if level > 35 and level < 65 then
        maxRuneCount = 2
    elseif level >= 65 then
        maxRuneCount = 3
    end
    return maxRuneCount
end

-- https://ffxiclopedia.fandom.com/wiki/Rune_Enchantment
xi.job_utils.rune_fencer.runeEnchantment = function(player, target, ability, effect)
    local level = getRUNLevel(target)
    local maxRunesForLevel = getMaxRunesForLevel(level)

    if target:getActiveRunesCount() == maxRunesForLevel then
        target:removeOldestRune()
    end

    -- Each rune gives this much resistance (stackable)
    local resistance = math.floor((48 * level / 99) + 5.5)
        -- TODO: + (2~10 Merits)
        -- TODO: + (1~20 JP)

    target:addStatusEffect(effect, resistance, 0, 300)

    -- Additional effect damage handled in core: battleutils::HandleRuneEffects

    return effect
end

xi.job_utils.rune_fencer.applyVallation = function(player)
    -- Gives -15% SDT per Rune for the related elements.
    local runeEffects = player:getRuneEffects()

    -- Pack first four into effect power
    -- Pack second four into effect sub-power
    -- Pack information about merit ranks into effect tier
    -- 00 = -0%
    -- 01 = -15%
    -- 10 = -30%
    -- 11 = -45%

    local power = 0
    local subPower = 0
    local tier = 0 -- TODO: Add reduction from merits
    local packIntoEffect = function(player, effectId)
        -- TODO: Modify power, subPower and tier
    end

    for idx, effect in ipairs(runeEffects) do
        local effectId = effect:getType()
        packIntoEffect(player, effectId)
    end

    local additionalDuration = 0 -- TODO: Add duration from JP
    target:addStatusEffectEx(xi.effects.VALLATION, xi.effects.VALLATION, power, 0, 180 + additionalDuration, 0, subPower, tier)
end
