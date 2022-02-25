-----------------------------------
-- Rune Fencer Job Utilities
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/weaponskills")
require("scripts/globals/jobpoints")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.rune_fencer = xi.job_utils.rune_fencer or {}
-----------------------------------

local function getRUNLevel(player)
    if player:getMainJob() == xi.job.RUN then
        return player:getMainLvl()
    else
        return player:getSubLvl()
    end
end

local function applyRuneEnhancement(effectType, player)
    local RUNLevel = getRUNLevel(player)
    local meritBonus =  player:getMerit(xi.merit.MERIT_RUNE_ENHANCE) -- 2 more elemental resistance per merit for a maximum total of (2*5) = 10 (power of merit is 2 per level)
    local jobPointBonus = player:getJobPointLevel(xi.jp.RUNE_ENCHANTMENT_EFFECT) -- 1 more elemental resistance per level for a maximum total of 20

    -- see https://www.bg-wiki.com/ffxi/Category:Rune
    local power = math.floor((49 * RUNLevel / 99) + 5.5) + meritBonus  + jobPointBonus
    player:addStatusEffect(effectType, power, 0, 300)
end

local function enforceRuneCounts(target)
    local RUNLevel = getRUNLevel(target)
    local maxRunes = RUNLevel >= 65 and 3 or RUNLevel >= 35 and 2 or 1
    local effects = target:getStatusEffects()
    local runes = {}
    local i = 0

    for _, effect in ipairs(effects) do
        local type = effect:getType()
        if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then
            runes[i+1] = effect
            i = i + 1
        end
    end

    if i >= maxRunes then -- delete the first rune in the list with the least duration
        target:delStatusEffect(runes[1]:getType())
    end
end


xi.job_utils.rune_fencer.useRuneEnchantment = function(player, target, ability, effect)
    enforceRuneCounts(target)
    applyRuneEnhancement(effect, target)
end
