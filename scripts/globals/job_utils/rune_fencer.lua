-----------------------------------
-- Rune Fencer Job Utilities
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/weaponskills")
require("scripts/globals/jobpoints")
require("scripts/globals/spells/spell_damage")
require("scripts/globals/utils")
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

    local activeRunes = target:getActiveRuneCount()
    if activeRunes >= maxRunes then -- delete the rune with the least duration
        target:removeOldestRune()
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

local function getVallationValianceSDTType(type)

    local runeSDTMap =
    {
        [xi.effect.IGNIS]    = xi.mod.ICE_SDT,
        [xi.effect.GELUS]    = xi.mod.WIND_SDT,
        [xi.effect.FLABRA]   = xi.mod.EARTH_SDT,
        [xi.effect.TELLUS]   = xi.mod.THUNDER_SDT,
        [xi.effect.SULPOR]   = xi.mod.WATER_SDT,
        [xi.effect.UNDA]     = xi.mod.FIRE_SDT,
        [xi.effect.LUX]      = xi.mod.DARK_SDT,
        [xi.effect.TENEBRAE] = xi.mod.LIGHT_SDT
    }
    return runeSDTMap[type]
end

local function getGambitSDTType(type)

    local runeSDTMap =
    {
        [xi.effect.IGNIS]    = xi.mod.FIRE_SDT,
        [xi.effect.GELUS]    = xi.mod.ICE_SDT,
        [xi.effect.FLABRA]   = xi.mod.WIND_SDT,
        [xi.effect.TELLUS]   = xi.mod.EARTH_SDT,
        [xi.effect.SULPOR]   = xi.mod.THUNDER_SDT,
        [xi.effect.UNDA]     = xi.mod.WATER_SDT,
        [xi.effect.LUX]      = xi.mod.LIGHT_SDT,
        [xi.effect.TENEBRAE] = xi.mod.DARK_SDT
    }
    return runeSDTMap[type]
end

local function getBattutaSpikesType(type)

    local runeSpikesMap =
    {
        [xi.effect.IGNIS]    = xi.subEffect.BLAZE_SPIKES,
        [xi.effect.GELUS]    = xi.subEffect.ICE_SPIKES,
        [xi.effect.FLABRA]   = xi.subEffect.GALE_SPIKES,
        [xi.effect.TELLUS]   = xi.subEffect.CLOD_SPIKES,
        [xi.effect.SULPOR]   = xi.subEffect.SHOCK_SPIKES,
        [xi.effect.UNDA]     = xi.subEffect.DELUGE_SPIKES,
        [xi.effect.LUX]      = xi.subEffect.REPSIRAL,
        [xi.effect.TENEBRAE] = xi.subEffect.DEATH_SPIKES,
    }
    return runeSpikesMap[type]
end

local function getSpecEffectElementWard(type) -- verified via !injectaction 15 1 1-8, retail action packet dumps

    local runeSpecEffectMap =
    {
        [xi.effect.IGNIS]    = 1,
        [xi.effect.GELUS]    = 2,
        [xi.effect.FLABRA]   = 3,
        [xi.effect.TELLUS]   = 4,
        [xi.effect.SULPOR]   = 5,
        [xi.effect.UNDA]     = 6,
        [xi.effect.LUX]      = 7,
        [xi.effect.TENEBRAE] = 8,
    }
    return runeSpecEffectMap[type]
end

local function getSpecEffectElementEffusion(type)

    local runeSpecEffectMap =
    {
        [xi.effect.IGNIS]    = 2,
        [xi.effect.GELUS]    = 4,
        [xi.effect.FLABRA]   = 6,
        [xi.effect.TELLUS]   = 8,
        [xi.effect.SULPOR]   = 10,
        [xi.effect.UNDA]     = 12,
        [xi.effect.LUX]      = 14,
        [xi.effect.TENEBRAE] = 16,
    }
    return runeSpecEffectMap[type]
end

local function getSwipeLungeElement(type)

    local runeElementEffectMap =
    {
        [xi.effect.IGNIS]    = xi.magic.ele.FIRE,
        [xi.effect.GELUS]    = xi.magic.ele.ICE,
        [xi.effect.FLABRA]   = xi.magic.ele.WIND,
        [xi.effect.TELLUS]   = xi.magic.ele.EARTH,
        [xi.effect.SULPOR]   = xi.magic.ele.THUNDER,
        [xi.effect.UNDA]     = xi.magic.ele.WATER,
        [xi.effect.LUX]      = xi.magic.ele.LIGHT,
        [xi.effect.TENEBRAE] = xi.magic.ele.DARK,
    }
    return runeElementEffectMap[type]
end

local function getAnimationSwipeLunge(weaponSkillType) -- verified via retail action packets exclusively

    local weaponAnimationMap =
    {
        [xi.skill.NONE]         = 6,
        [xi.skill.HAND_TO_HAND] = 6,
        [xi.skill.DAGGER]       = 7,
        [xi.skill.SWORD]        = 5,
        [xi.skill.GREAT_SWORD]  = 10,
        [xi.skill.AXE]          = 8, -- club/axe share the same animation for Swipe/Lunge
        [xi.skill.GREAT_AXE]    = 9, -- gaxe/scythe share the animation for Swipe/Lunge
        [xi.skill.SCYTHE]       = 9,
        [xi.skill.POLEARM]      = 11,
        [xi.skill.KATANA]       = 12,
        [xi.skill.GREAT_KATANA] = 13,
        [xi.skill.CLUB]         = 8,
        [xi.skill.STAFF]        = 14,
    }
    return weaponAnimationMap[weaponSkillType]
end

local function getAnimationGambit(weaponSkillType) -- verified via retail action packets exclusively

    local weaponAnimationMap =
    {
        [xi.skill.NONE]         = 16,
        [xi.skill.HAND_TO_HAND] = 16,
        [xi.skill.DAGGER]       = 17,
        [xi.skill.SWORD]        = 15,
        [xi.skill.GREAT_SWORD]  = 20,
        [xi.skill.AXE]          = 18, -- club/axe share the same animation for Gambit
        [xi.skill.GREAT_AXE]    = 19, -- gaxe/scythe share the animation for Gambit
        [xi.skill.SCYTHE]       = 19,
        [xi.skill.POLEARM]      = 21,
        [xi.skill.KATANA]       = 22,
        [xi.skill.GREAT_KATANA] = 23,
        [xi.skill.CLUB]         = 18,
        [xi.skill.STAFF]        = 24,
    }
    return weaponAnimationMap[weaponSkillType]
end

local function getAnimationRayke(weaponSkillType) -- verified via retail action packets exclusively

    local weaponAnimationMap =
    {
        [xi.skill.NONE]         = 26,
        [xi.skill.HAND_TO_HAND] = 26,
        [xi.skill.DAGGER]       = 27,
        [xi.skill.SWORD]        = 25,
        [xi.skill.GREAT_SWORD]  = 30,
        [xi.skill.AXE]          = 28, -- club/axe share the same animation for Rayke
        [xi.skill.GREAT_AXE]    = 29, -- gaxe/scythe share the animation for Rayke
        [xi.skill.SCYTHE]       = 29,
        [xi.skill.POLEARM]      = 31,
        [xi.skill.KATANA]       = 32,
        [xi.skill.GREAT_KATANA] = 33,
        [xi.skill.CLUB]         = 28,
        [xi.skill.STAFF]        = 34,
    }
    return weaponAnimationMap[weaponSkillType]
end

local function applyVallationValianceSDTMods(target, SDTTypes, power, effect, duration) -- Vallation/Valiance can apply up to N where N is total rune different elemental resistances, or power*N for singular element, or any combination thereof.
    local effectAdded = target:addStatusEffect(effect, power, 0, duration)

    if effectAdded then
        local newEffect = target:getStatusEffect(effect)

        for _, SDT in ipairs(SDTTypes) do
            target:addMod(SDT, power)
            newEffect:addMod(SDT, power) -- due to order of events, this only adds mods to the container, not to the owner of the effect.
        end
    end
end

local function applyGambitSDTMods(target, SDTTypes, power, effect, duration) -- Gambit can apply up to N where N is total rune different elemental resistance decreases, or power*N for singular element, or any combination thereof.
    local effectAdded = target:addStatusEffect(effect, power, 0, duration)

    if effectAdded then
        local newEffect = target:getStatusEffect(effect)

        for _, SDT in ipairs(SDTTypes) do
            target:addMod(SDT, power)
            newEffect:addMod(SDT, power) -- due to order of events, this only adds mods to the container, not to the owner of the effect.
        end
    end
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
        target:addMod(xi.mod.SUBTLE_BLOW, subPower)
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
        target:delMod(xi.mod.SUBTLE_BLOW, subPower)
    end
end

xi.job_utils.rune_fencer.useVivaciousPulse = function(player, target, ability, effect)
    return calculateVivaciousPulseHealing(player, target)
end

xi.job_utils.rune_fencer.checkHaveRunes = function(player)

    if player:getActiveRuneCount() > 0 then
        return 0, 0
    end

    return  xi.msg.basic.REQUIRE_RUNE, 0 -- That action requires the ability Rune Enchantment.
end

--see https://www.bg-wiki.com/ffxi/Vallation, https://www.bg-wiki.com/ffxi/Valiance, https://www.bg-wiki.com/ffxi/Inspiration
xi.job_utils.rune_fencer.useVallationValiance = function(player, target, ability, action)

    local abilityID = ability:getID()

    local highestRune = player:getHighestRuneEffect()

    action:speceffect(target:getID(), getSpecEffectElementWard(highestRune)) -- set element color for animation. This is set even on "sub targets" for valiance on retail even if the animation doesn't seem to change.

    if player:getID() ~= target:getID() then -- Only the caster can apply effects, including to the party if valiance.

        if abilityID == xi.jobAbility.VALIANCE and target:hasStatusEffect(xi.effect.VALLATION) then -- Valiance is being used on them, and they have Vallation already up
            action:messageID(target:getID(), xi.msg.basic.NO_EFFECT) -- "No effect on <Target>"
        end
        return
    end

    local effects = target:getStatusEffects()
    local SDTPower = 15
    local meritBonus =  player:getMerit(xi.merit.MERIT_VALLATION_EFFECT)
    local inspirationMerits = player:getMerit(xi.merit.MERIT_INSPIRATION)
    local inspirationFCBonus = inspirationMerits + inspirationMerits / 10 * player:getMod(xi.mod.ENHANCES_INSPIRATION)  -- 10 FC per merit level, plus 2% per level from AF2 leg aug
    local jobPointBonusDuration = player:getJobPointLevel(xi.jp.VALLATION_DURATION)

    SDTPower = (SDTPower + meritBonus) * 100

    local SDTTypes = {} -- one SDT type per rune which can be additive
    local i = 0

    for _, effect in ipairs(effects) do
        local type = effect:getType()

        if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then
            local SDTType = getVallationValianceSDTType(type)
            SDTTypes[i+1] = SDTType
            i = i + 1
        end
    end

    if abilityID == xi.jobAbility.VALIANCE then -- apply effects to entire party (including target) (Valiance)
        local party = player:getParty()
        local duration = 120 + jobPointBonusDuration

        for _, member in pairs(party) do
            if not member:hasStatusEffect(xi.effect.VALLATION) then -- Valiance has no effect if Vallation is up

                member:delStatusEffectSilent(xi.effect.VALIANCE) -- Remove Valiance if it's already up. The new one will overwrite.
                applyVallationValianceSDTMods(member, SDTTypes, SDTPower, xi.effect.VALIANCE, duration)

                if inspirationFCBonus > 0 then -- Inspiration FC is not applied unless Valiance is applied, tested on retail with 2 RUN in a party
                    member:addStatusEffect(xi.effect.FAST_CAST, inspirationFCBonus, 0, duration)
                end
            elseif member:getID() == player:getID() then -- caster has Vallation, set no effect message.
                    action:messageID(player:getID(), xi.msg.basic.JA_NO_EFFECT_2) -- "<Player> uses Valiance.\nNo effect on <Player>."
            end

        end
    else -- apply effects to target (Vallation)
        local duration = 180 + jobPointBonusDuration

        target:delStatusEffectSilent(xi.effect.VALIANCE) -- Vallation overwrites Valiance
        applyVallationValianceSDTMods(target, SDTTypes, SDTPower, xi.effect.VALLATION, duration)

        if inspirationFCBonus > 0 then
           target:addStatusEffect(xi.effect.FAST_CAST, inspirationFCBonus, 0, duration)
        end
    end
end

xi.job_utils.rune_fencer.onVallationValianceEffectGain = function(target, effect)
    -- intentionally blank, handled in applyVallationValianceSDTMods
end

xi.job_utils.rune_fencer.onVallationValianceEffectLose = function(target, effect)
    -- intentionally blank, the effect has a mod list that is deleted after this event is called in CStatusEffectContainer::RemoveStatusEffect
end

-- see https://www.bg-wiki.com/ffxi/Battuta
xi.job_utils.rune_fencer.useBattuta = function(player, target, ability, action)

    local meritPower = player:getMerit(xi.merit.MERIT_BATTUTA) -- power is 4
    local modBonus = (100 + (player:getMod(xi.mod.ENHANCES_BATTUTA) *  meritPower / 4)) / 100
    local inquartataPower = 36 + meritPower -- base 36% + merit power of 4% each = max of 56%
    local spikesPower = 6 + meritPower    -- damage is static 26 per rune barring SDT/MDT at 5/5 Battuta merits. 6 + 4*5 = 26.
    local runeCount = target:getActiveRuneCount()

    spikesPower = spikesPower * runeCount

    local highestRune = target:getHighestRuneEffect()
    action:speceffect(target:getID(), getSpecEffectElementWard(highestRune)) -- set element color for animation.

    target:addStatusEffect(xi.effect.BATTUTA, inquartataPower, 0, 90, 0, math.floor(spikesPower * modBonus), 0)
end

xi.job_utils.rune_fencer.onBattutaEffectGain = function(target, effect)

    local highestRune = target:getHighestRuneEffect()
    local spikesType = getBattutaSpikesType(highestRune)

    effect:addMod(xi.mod.INQUARTATA,effect:getPower())

    local spikesPower = effect:getSubPower()
    if spikesPower > 0 then
        effect:addMod(xi.mod.PARRY_SPIKES, spikesType)
        effect:addMod(xi.mod.PARRY_SPIKES_DMG, effect:getSubPower())
    end
end

xi.job_utils.rune_fencer.onBattutaEffectLose = function(target, effect)
    -- handled after EFFECT_LOSE in cpp
end

local function getSwipeLungeDamageMultipliers(player, target, element, bonusMacc) -- get these multipliers once and store them
    local multipliers = {}

    multipliers.eleStaffBonus        = xi.spells.spell_damage.calculateEleStaffBonus(player, nil, element)
    multipliers.magianAffinity       = xi.spells.spell_damage.calculateMagianAffinity(player, nil)         -- presumed but untested
    multipliers.SDT                  = xi.spells.spell_damage.calculateSDT(player, target, nil, element)
    multipliers.resist               = xi.spells.spell_damage.calculateResist(player, target,  nil, 0, element, 0, bonusMacc)
    multipliers.magicBurst           = xi.spells.spell_damage.calculateIfMagicBurst(player, target,  0, element)
    multipliers.magicBurstBonus      = xi.spells.spell_damage.calculateIfMagicBurstBonus(player, target, nil, 0, element)
    multipliers.dayAndWeather        = xi.spells.spell_damage.calculateDayAndWeather(player, target, nil, 0, element)
    multipliers.magicBonusDiff       = xi.spells.spell_damage.calculateMagicBonusDiff(player, target, nil, 0, 0, element)
    multipliers.TMDA                 = xi.spells.spell_damage.calculateTMDA(player, target, nil)
    multipliers.nukeAbsorbOrNullify  = xi.spells.spell_damage.calculateNukeAbsorbOrNullify(player, target, nil, element)

    return multipliers
end

local function calculateSwipeLungeDamage(player, target, skillModifier, gearBonus, numHits, multipliers)

    local damage = math.floor(skillModifier *  (0.50 + 0.25 * numHits  + (gearBonus / 100)))

    damage = damage + player:getMod(xi.mod.MAGIC_DAMAGE) -- add mdamage to base damage

    damage = math.floor(damage * multipliers.eleStaffBonus)
    damage = math.floor(damage * multipliers.magianAffinity)
    damage = math.floor(damage * multipliers.SDT)
    damage = math.floor(damage * multipliers.resist)
    damage = math.floor(damage * multipliers.magicBurst)
    damage = math.floor(damage * multipliers.magicBurstBonus)
    damage = math.floor(damage * multipliers.dayAndWeather)
    damage = math.floor(damage * multipliers.magicBonusDiff)
    damage = math.floor(damage * multipliers.TMDA)
    damage = math.floor(damage * multipliers.nukeAbsorbOrNullify)

    damage = target:magicDmgTaken(damage)

    -- Handle Phalanx
    if damage > 0 then
        damage = utils.clamp(damage - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- Handle Stoneskin
    if damage > 0 then
        damage = utils.clamp(utils.stoneskin(target, damage), -99999, 99999)
    end

    return damage
end

-- see https://www.bg-wiki.com/ffxi/Lunge. Swipe is just lunge, but with only one rune.
xi.job_utils.rune_fencer.useSwipeLunge = function(player, target, ability, action)
    local abilityID = ability:getID()
    local newestRuneEffect = player:getNewestRuneEffect()
    local highestRuneEffect = player:getHighestRuneEffect()
    local highestRuneEffectCount = player:countEffect(highestRuneEffect)

    local weaponSkillType = player:getWeaponSkillType(xi.slot.MAIN)
    local gearBonus = player:getMod(xi.mod.SWIPE)
    local jobPointBonus = player:getJobPointLevel(xi.jp.SWIPE_EFFECT)
    local bonusMacc = player:getMerit(xi.merit.MERIT_RUNE_ENHANCE)
    local numHits = 1

    if abilityID == xi.jobAbility.LUNGE then   -- Lunge uses each rune individually
        numHits = player:getActiveRuneCount()  -- num hits equals num active runes
    end

    local skillModifier = (player:getSkillLevel(weaponSkillType) + player:getILvlSkill()) * ((100 + jobPointBonus) / 100)

    local shadowsHit = 0
    local cumulativeDamage = 0
    local runesUsed = 0
    local absorbed = false
    local magicBursted = false
    target:updateClaim(player) -- claim target in case we end up doing 0 damage through shadows

    for i = 0, numHits-1, 1
    do
        newestRuneEffect = player:getNewestRuneEffect()
        local element = getSwipeLungeElement(newestRuneEffect)
        player:removeNewestRune() --rune is always consumed if target is still alive
        runesUsed = runesUsed + 1 -- keep track of runes used to change effect later

        local shadows = utils.takeShadows(target, 1, 1)

        if shadows == 0 then -- we hit a shadow, increment shadow counter and do nothing else.
            shadowsHit = shadowsHit + 1
        else
            local runeStrength = 1
            if newestRuneEffect == highestRuneEffect then
                runeStrength = highestRuneEffectCount
            end

            local multipliers = getSwipeLungeDamageMultipliers(player, target, element, bonusMacc) -- store multipliers in case we need them for lowering rune strength on lunge
            local damage = calculateSwipeLungeDamage(player, target, skillModifier, gearBonus, runeStrength, multipliers)

            -- set absorb flag in case we end up dealing 0 damage cumulatively. For example using a wind swipe/lunge vs Puk with full hp will report it "absorbed" 0 HP.
            if multipliers.nukeAbsorbOrNullify == -1 then
                absorbed = true
            end

            -- Handle Magic Absorb
            if damage < 0 then
                damage = target:addHP(-damage)
            else
                -- We dealt damage. Check if we are going to kill it, and if we can kill it with less rune strength if rune strength > 1.
                if numHits > 1 and runesUsed ~= numHits and target:getHP()-damage <= 0 and runeStrength > 1 then -- try less duplicate rune count if not on final duplicate rune
                    for x = 1, runeStrength-1, 1
                    do
                        local lowerRuneStrengthDamage = calculateSwipeLungeDamage(player, target, skillModifier, gearBonus, runeStrength-x, multipliers)
                        if target:getHP()-lowerRuneStrengthDamage <= 0 then
                            damage = lowerRuneStrengthDamage
                        end
                    end
                end

                target:takeSwipeLungeDamage(player, damage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + element)
                -- Handle Afflatus Misery.
                target:handleAfflatusMiseryDamage(damage)
                -- Handle Enmity.
                target:updateEnmityFromDamage(player, damage)
            end

            cumulativeDamage = cumulativeDamage + damage

            if multipliers.magicBurst > 1 then
                magicBursted = true
            end

            if target:getHP() <= 0 then -- we killed it, stop.
                break
            end
        end
    end

    if runesUsed < 2 or (runesUsed == numHits and highestRuneEffectCount == 1) then          -- element strength is equal
        action:speceffect(target:getID(), getSpecEffectElementEffusion(newestRuneEffect))    -- set element color to the last rune used
    else
        action:speceffect(target:getID(), getSpecEffectElementEffusion(highestRuneEffect))   -- set element color to the strongest effect
    end

    if shadowsHit == numHits and cumulativeDamage == 0 then
        action:messageID(target:getID(), xi.msg.basic.SHADOW_ABSORB) -- set message to blinked hit(s)
        return shadowsHit
    end

    action:setAnimation(target:getID(), getAnimationSwipeLunge(weaponSkillType)) -- set animation for currently equipped weapon

    if cumulativeDamage < 0 or cumulativeDamage == 0 and absorbed then -- TODO: figre out how to set "unknown" bit in message 102
                                                                       -- "unknown" = 4 on message 102 for healed MB
        action:messageID(target:getID(), xi.msg.basic.JA_RECOVERS_HP)
    end

    if magicBursted then -- TODO: set MB message somehow by setting "unknown" = 4 on message 110 for MB
    end

    return cumulativeDamage
end

-- see http://wiki.ffo.jp/html/1720.html, the effects resisted are against the strong element.
-- for example, Amnesia is fire based, therefore water runes (Unda) add resist Amnesia.
-- These effects seem to match the "Resist X" traits that all jobs have, including unused player traits that made it into autotranslate; Resist Curse/Charm
local function addPflugResistType(type, effect, power)

    if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then

        local pflugResistTypes =
        {
            [xi.effect.IGNIS]    = {xi.mod.PARALYZERES, xi.mod.BINDRES},
            [xi.effect.GELUS]    = {xi.mod.SILENCERES, xi.mod.GRAVITYRES},
            [xi.effect.FLABRA]   = {xi.mod.PETRIFYRES, xi.mod.SLOWRES},
            [xi.effect.TELLUS]   = {xi.mod.STUNRES},
            [xi.effect.SULPOR]   = {xi.mod.POISONRES},
            [xi.effect.UNDA]     = {xi.mod.AMNESIARES, xi.mod.PLAGUERES},
            [xi.effect.LUX]      = {xi.mod.SLEEPRES, xi.mod.BLINDRES, xi.mod.CURSERES},
            [xi.effect.TENEBRAE] = {xi.mod.CHARMRES},
        }

        local resistTypes = pflugResistTypes[type]

        for _, resistMod in pairs(resistTypes) do -- store mod in effect, this function is triggered from event onEffectGain so it adds to the player automatically.
            effect:addMod(resistMod, power)
        end

    end
end

xi.job_utils.rune_fencer.onPflugEffectGain = function(target, effect)
    local statusEffects = target:getStatusEffects()

    for _, statusEffect in ipairs(statusEffects) do
        local type = statusEffect:getType()
        addPflugResistType(type, effect, effect:getPower() + effect:getSubPower())
    end
end

xi.job_utils.rune_fencer.onPflugEffectLose = function(target, effect)
    -- intentionally blank, the effect has a mod list that is deleted after this event is called in CStatusEffectContainer::RemoveStatusEffect
end

xi.job_utils.rune_fencer.usePflug = function(player, target, ability, action)
    local highestRune = player:getHighestRuneEffect()
    local baseStrength = 10
    local meritBonus =  player:getMerit(xi.merit.MERIT_PFLUG_EFFECT)

    if player:getMainJob() == xi.job.RUN then
        baseStrength = 15
    end

    action:speceffect(target:getID(), getSpecEffectElementWard(highestRune))

    player:addStatusEffect(xi.effect.PFLUG, baseStrength, 0, 120, 0, meritBonus)
end

-- see https://www.bg-wiki.com/ffxi/Gambit
xi.job_utils.rune_fencer.useGambit = function(player, target, ability, action)
    local highestRune = player:getHighestRuneEffect()
    local weaponSkillType = player:getWeaponSkillType(xi.slot.MAIN)
    local effects = player:getStatusEffects()
    local SDTPower = -10
    local jobPointBonusDuration = player:getJobPointLevel(xi.jp.GAMBIT_DURATION)
    local gearBonusDuration = player:getMod(xi.mod.GAMBIT_DURATION)

    action:speceffect(target:getID(), getSpecEffectElementEffusion(highestRune)) -- set element color for animation.
    action:setAnimation(target:getID(), getAnimationGambit(weaponSkillType)) -- set animation for currently equipped weapon

    SDTPower = SDTPower * 100 -- adjust to SDT modifier

    local SDTTypes = {} -- one SDT type per rune which can be additive
    local i = 0

    for _, effect in ipairs(effects) do
        local type = effect:getType()

        if type >= xi.effect.IGNIS and type <= xi.effect.TENEBRAE then
            local SDTType = getGambitSDTType(type)
            SDTTypes[i+1] = SDTType
            i = i + 1
        end
    end
    local duration = 60 + jobPointBonusDuration + gearBonusDuration

    applyGambitSDTMods(target, SDTTypes, SDTPower, xi.effect.GAMBIT, duration)

    player:removeAllRunes()
end
