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
    local oldestRune = nil
    local oldestRuneDuration = 0
    local i = 0

    for _, effect in ipairs(effects) do
        local type = effect:getType()
        if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then

            local remainingDuration = effect:getTimeRemaining()

            if oldestRune == nil then
                oldestRune = type
                oldestRuneDuration = remainingDuration
            elseif remainingDuration < oldestRuneDuration then
                oldestRune = type
                oldestRuneDuration = remainingDuration
            end
            i = i + 1
        end
    end
    if i >= maxRunes then -- delete the rune with the least duration
        target:delStatusEffectSilent(oldestRune)
    end
end

--source https://www.bluegartr.com/threads/124844-Vivacious-Pulse-testing?p=6038534&viewfull=1#post6038534 and following posts
local function getRuneHealAmount(type, target)

    if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then

        if type == xi.effect.TENEBRAE then -- Tenebrae primarily restores MP, but also uses the base divine skill/2 bonus but no raw stat bonus.
            return 0
        end

        local runeStatMap =
        {
            [xi.effect.IGNIS]  = xi.mod.STR,
            [xi.effect.GELUS]  = xi.mod.DEX,
            [xi.effect.FLABRA] = xi.mod.VIT,
            [xi.effect.TELLUS] = xi.mod.AGI,
            [xi.effect.SULPOR] = xi.mod.INT,
            [xi.effect.UNDA]   = xi.mod.MND,
            [xi.effect.LUX]    = xi.mod.CHR,
        }
        return math.floor(target:getStat(runeStatMap[type]) * 0.5)
    end

    return 0
end

-- source https://www.bg-wiki.com/ffxi/Vivacious_Pulse
local function calculateVivaciousPulseHealing(target)

    local divineMagicSkillLevel = target:getSkillLevel(xi.skill.DIVINE_MAGIC)
    local HPHealAmount = 10 + math.floor(divineMagicSkillLevel / 2 * (100 + target:getJobPointLevel(xi.jp.VIVACIOUS_PULSE_EFFECT)) / 100) -- Bonus of 1-20%  from Vivacious pulse job points.
    local tenebraeRuneCount = 0
    local bonusPct = (100 + target:getMod(xi.mod.VIVACIOUS_PULSE_POTENCY)) / 100

    local debuffs = {}
    local debuffCount = 0

    local removableDebuffMap = -- map of debuffs that can be removed by AF3 head augment
    {
        [xi.effect.POISON]        = true,
        [xi.effect.PARALYSIS]     = true,
        [xi.effect.BLINDNESS]     = true,
        [xi.effect.SILENCE]       = true,
        [xi.effect.MUTE]          = true,
        [xi.effect.CURSE_I]       = true,
        [xi.effect.CURSE_II]      = true,
        [xi.effect.DOOM]          = true,
        [xi.effect.PLAGUE]        = true,
        [xi.effect.DISEASE]       = true,
        [xi.effect.PETRIFICATION] = true,
    }

    local effects = target:getStatusEffects()
    for _, effect in ipairs(effects) do
        local type = effect:getType()

        HPHealAmount = HPHealAmount + getRuneHealAmount(type, target) -- type checked internally

        if removableDebuffMap[type] ~= nil then -- effect in debuff table, count it as a debuff.
            debuffs[debuffCount+1] = type
            debuffCount = debuffCount + 1
        end

        if type == xi.effect.TENEBRAE then -- runes that also restore MP
            tenebraeRuneCount = tenebraeRuneCount + 1
        end
    end

    if tenebraeRuneCount > 0 then -- only restore MP if there's one or more tenebrae rune active
        local MPHealAmount = math.floor(divineMagicSkillLevel / 10 * (100 + target:getJobPointLevel(xi.jp.VIVACIOUS_PULSE_EFFECT)) / 100) * (tenebraeRuneCount + 1)
        target:addMP(MPHealAmount) -- augment bonusPct does not apply here according to testing.
    end

    if debuffCount > 0 and target:getMod(xi.mod.AUGMENTS_VIVACIOUS_PULSE) > 0 then -- add random removal of Poison, Paralyze, Blind, Silence, Mute, Curse, Bane, Doom, Virus, Plague, Petrification via AF3 head (source: https://www.bg-wiki.com/ffxi/Erilaz_Galea)
        target:delStatusEffect(debuffs[math.random(debuffCount)])
    end

    HPHealAmount = HPHealAmount * bonusPct
    if target:getHP() + HPHealAmount > target:getMaxHP() then
        HPHealAmount = target:getMaxHP() - target:getHP() -- don't go over cap
    end

    target:restoreHP(HPHealAmount)

    return HPHealAmount
end

xi.job_utils.rune_fencer.useRuneEnchantment = function(player, target, ability, effect)
    enforceRuneCounts(target)
    applyRuneEnhancement(effect, target)
end

xi.job_utils.rune_fencer.useSwordplay = function(player, target, ability)
    local power = 0 --Swordplay starts at +0 bonus without swaps

    -- see https://www.bg-wiki.com/ffxi/Sleight_of_Sword for levels
    local meritBonus =  player:getMerit(xi.merit.MERIT_SLEIGHT_OF_SWORD)
    local augBonus = 0 -- augBonus = 2 per level of merit

    -- gear bonuses from https://www.bg-wiki.com/ffxi/Swordplay
    if player:getMainJob() == xi.job.RUN and target:getMainLvl() == 99 then -- don't bother with gear boost checks until 99 and main RUN
        local tickPower = 3 -- Tick power appears to be 3/tick, not 6/tick if RUN main and 3/tick if RUN sub; source : https://www.ffxiah.com/forum/topic/37086/endeavoring-to-awaken-a-guide-to-rune-fencer/180/#3615377

        -- add starting tick bonuses if appropriate gear is equipped
        power = tickPower + player:getMod(xi.mod.SWORDPLAY)
    end

    if power > 0 then -- add aug bonus if appropriate gear is equipped. Note: ilvl 109+ "relic" or "AF2" gear always has the augment, so no need to check extdata. RUN does not have AF/AF2/AF3 gear below i109.
        augBonus = (meritBonus / 5) * 2
    end

    player:addStatusEffect(xi.effect.SWORDPLAY, power, 3, 120, 0, meritBonus + augBonus, 0)
end

xi.job_utils.rune_fencer.onSwordplayEffectGain = function(target, effect)
    local power = effect:getPower()
    local subPower = effect:getSubPower()

    if power > 0 then
        target:addMod(xi.mod.ACC, power)
        target:addMod(xi.mod.EVASION, power)
    end

    if subPower > 0 then
        target:addMod(xi.mod.SUBTLE_BLOW,subPower)
    end
end

-- tick values from https://www.bg-wiki.com/ffxi/Swordplay
xi.job_utils.rune_fencer.onSwordplayEffectTick = function (target, effect)
    local power  = effect:getPower()
    local tickPower = 3
    local jobPointBonus = target:getJobPointLevel(xi.jp.SWORDPLAY_EFFECT)
    local maxPower = 60 + jobPointBonus  -- ACC/EVA bonus caps at 60, + 1 per level of job point.

    if power < maxPower then
        if power + tickPower > maxPower then
            tickPower = maxPower - power
        end

        if tickPower > 0 then
            target:addMod(xi.mod.ACC, tickPower)
            target:addMod(xi.mod.EVASION, tickPower)
        end

        power = math.min(power + tickPower, maxPower)
        effect:setPower(power)
    end
end

xi.job_utils.rune_fencer.onSwordplayEffectLose = function (target, effect)
    local power = effect:getPower()
    local subPower = effect:getSubPower()

    target:delMod(xi.mod.ACC, power)
    target:delMod(xi.mod.EVASION, power)

    if subPower > 0 then
        target:delMod(xi.mod.SUBTLE_BLOW,subPower)
    end
end

xi.job_utils.rune_fencer.useVivaciousPulse = function(player, target, ability, effect)
    return calculateVivaciousPulseHealing(player, target)
end
