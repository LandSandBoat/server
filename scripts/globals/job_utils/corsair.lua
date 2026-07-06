-----------------------------------
-- Corsair Job Utilities
-----------------------------------
require('scripts/globals/combat/damage_multipliers')
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.corsair = xi.job_utils.corsair or {}
-----------------------------------

-----------------------------------
-- Data tables
-----------------------------------

-- Table used for Corsair's Phantom Roll calculations
xi.job_utils.corsair.rollData =
{
    [xi.jobAbility.CORSAIRS_ROLL] =
    {
        effect      = xi.effect.CORSAIRS_ROLL,
        powers      = { 10, 11, 11, 12, 20, 13, 15, 16, 8, 17, 24 },
        phantomBase = 2,
        bonus       = 0,
        bonusJob    = xi.job.COR,
        bustPower   = 6,
        bustMod     = xi.mod.EXP_BONUS,
    },

    [xi.jobAbility.NINJA_ROLL] =
    {
        effect      = xi.effect.NINJA_ROLL,
        powers      = { 10, 13, 15, 40, 18, 20, 25, 5, 28, 30, 50 },
        phantomBase = 2,
        bonus       = 15,
        bonusJob    = xi.job.NIN,
        bustPower   = 15,
        bustMod     = xi.mod.EVA,
    },

    [xi.jobAbility.HUNTERS_ROLL] =
    {
        effect      = xi.effect.HUNTERS_ROLL,
        powers      = { 10, 13, 15, 40, 18, 20, 25, 5, 27, 30, 50 },
        phantomBase = 5,
        bonus       = 15,
        bonusJob    = xi.job.RNG,
        bustPower   = 5,
        bustMod     = xi.mod.ACC,
    },

    [xi.jobAbility.CHAOS_ROLL] =
    {
        effect      = xi.effect.CHAOS_ROLL,
        powers      = { 6, 8, 9, 25, 11, 13, 16, 3, 17, 19, 31 },
        phantomBase = 3,
        bonus       = 10,
        bonusJob    = xi.job.DRK,
        bustPower   = 10,
        bustMod     = xi.mod.ATTP,
    },

    [xi.jobAbility.MAGUSS_ROLL] =
    {
        effect      = xi.effect.MAGUSS_ROLL,
        powers      = { 5, 20, 6, 8, 9, 3, 10, 13, 14, 15, 25 },
        phantomBase = 2,
        bonus       = 8,
        bonusJob    = xi.job.BLU,
        bustPower   = 5,
        bustMod     = xi.mod.MDEF,
    },

    [xi.jobAbility.HEALERS_ROLL] =
    {
        effect      = xi.effect.HEALERS_ROLL,
        powers      = { 3, 4, 12, 5, 6, 7, 1, 8, 9, 10, 16 },
        phantomBase = 3,
        bonus       = 4,
        bonusJob    = xi.job.WHM,
        bustPower   = 4,
        bustMod     = xi.mod.CURE_POTENCY_RCVD,
    },

    [xi.jobAbility.DRACHEN_ROLL] =
    {
        effect      = xi.effect.DRACHEN_ROLL,
        powers      = { 10, 13, 15, 40, 18, 20, 25, 5, 28, 30, 50 },
        phantomBase = 5,
        bonus       = 15,
        bonusJob    = xi.job.DRG,
        bustPower   = 15,
        bustMod     = xi.mod.NONE, -- no known bust penalty; buff applies to pet only
    },

    [xi.jobAbility.CHORAL_ROLL] =
    {
        effect      = xi.effect.CHORAL_ROLL,
        powers      = { 13, 55, 17, 20, 25, 8, 30, 35, 40, 45, 65 },
        phantomBase = 4,
        bonus       = 25,
        bonusJob    = xi.job.BRD,
        bustPower   = 25,
        bustMod     = xi.mod.SPELLINTERRUPT,
    },

    [xi.jobAbility.MONKS_ROLL] =
    {
        effect      = xi.effect.MONKS_ROLL,
        powers      = { 8, 10, 32, 12, 14, 16, 4, 20, 22, 24, 40 },
        phantomBase = 4,
        bonus       = 10,
        bonusJob    = xi.job.MNK,
        bustPower   = 11,
        bustMod     = xi.mod.SUBTLE_BLOW,
    },

    [xi.jobAbility.BEAST_ROLL] =
    {
        effect      = xi.effect.BEAST_ROLL,
        powers      = { 4, 5, 7, 19, 8, 9, 11, 2, 13, 14, 23 },
        phantomBase = 3,
        bonus       = 10,
        bonusJob    = xi.job.BST,
        bustPower   = 7,
        bustMod     = xi.mod.NONE, -- no known bust penalty; buff applies to pet only
    },

    [xi.jobAbility.SAMURAI_ROLL] =
    {
        effect      = xi.effect.SAMURAI_ROLL,
        powers      = { 8, 32, 10, 12, 14, 4, 16, 20, 22, 24, 40 },
        phantomBase = 4,
        bonus       = 10,
        bonusJob    = xi.job.SAM,
        bustPower   = 5,
        bustMod     = xi.mod.STORETP,
    },

    [xi.jobAbility.EVOKERS_ROLL] =
    {
        effect      = xi.effect.EVOKERS_ROLL,
        powers      = { 1, 1, 1, 1, 3, 2, 2, 2, 1, 3, 4 },
        phantomBase = 1,
        bonus       = 1,
        bonusJob    = xi.job.SMN,
        bustPower   = 1,
        bustMod     = xi.mod.REFRESH,
    },

    [xi.jobAbility.ROGUES_ROLL] =
    {
        effect      = xi.effect.ROGUES_ROLL,
        powers      = { 2, 2, 3, 4, 12, 5, 6, 6, 1, 8, 19 },
        phantomBase = 1,
        bonus       = 6,
        bonusJob    = xi.job.THF,
        bustPower   = 6,
        bustMod     = xi.mod.CRITHITRATE,
    },

    [xi.jobAbility.WARLOCKS_ROLL] =
    {
        effect      = xi.effect.WARLOCKS_ROLL,
        powers      = { 10, 13, 15, 40, 18, 20, 25, 5, 28, 30, 50 },
        phantomBase = 1,
        bonus       = 15,
        bonusJob    = xi.job.RDM,
        bustPower   = 15,
        bustMod     = xi.mod.MACC,
    },

    [xi.jobAbility.FIGHTERS_ROLL] =
    {
        effect      = xi.effect.FIGHTERS_ROLL,
        powers      = { 2, 2, 3, 4, 12, 5, 6, 7, 1, 9, 18 },
        phantomBase = 1,
        bonus       = 6,
        bonusJob    = xi.job.WAR,
        bustPower   = 6,
        bustMod     = xi.mod.DOUBLE_ATTACK,
    },

    [xi.jobAbility.PUPPET_ROLL] =
    {
        effect      = xi.effect.PUPPET_ROLL,
        powers      = { 4, 5, 18, 7, 9, 10, 2, 11, 13, 15, 22 },
        phantomBase = 3,
        bonus       = 8,
        bonusJob    = xi.job.PUP,
        bustPower   = 8,
        bustMod     = xi.mod.NONE, -- no known bust penalty; buff applies to pet only
    },

    [xi.jobAbility.GALLANTS_ROLL] =
    {
        effect      = xi.effect.GALLANTS_ROLL,
        powers      = { 600, 800, 2400, 900, 1100, 1200, 300, 1500, 1700, 1800, 3000 },
        phantomBase = 234,
        bonus       = 500,
        bonusJob    = xi.job.PLD,
        bustPower   = 500,
        bustMod     = xi.mod.DMG,
    },

    [xi.jobAbility.WIZARDS_ROLL] =
    {
        effect      = xi.effect.WIZARDS_ROLL,
        powers      = { 4, 6, 8, 10, 25, 12, 14, 17, 2, 20, 30 },
        phantomBase = 2,
        bonus       = 10,
        bonusJob    = xi.job.BLM,
        bustPower   = 10,
        bustMod     = xi.mod.MATT,
    },

    [xi.jobAbility.DANCERS_ROLL] =
    {
        effect      = xi.effect.DANCERS_ROLL,
        powers      = { 3, 4, 12, 5, 6, 7, 1, 8, 9, 10, 16 },
        phantomBase = 2,
        bonus       = 4,
        bonusJob    = xi.job.DNC,
        bustPower   = 4,
        bustMod     = xi.mod.REGEN,
    },

    [xi.jobAbility.SCHOLARS_ROLL] =
    {
        effect      = xi.effect.SCHOLARS_ROLL,
        powers      = { 2, 9, 3, 4, 5, 2, 6, 6, 7, 9, 14 },
        phantomBase = 1,
        bonus       = 4,
        bonusJob    = xi.job.SCH,
        bustPower   = 4,
        bustMod     = xi.mod.CONSERVE_MP,
    },

    [xi.jobAbility.NATURALISTS_ROLL] =
    {
        effect      = xi.effect.NATURALISTS_ROLL,
        powers      = { 6, 7, 15, 8, 9, 10, 5, 11, 12, 13, 20 },
        phantomBase = 1,
        bonus       = 5,
        bonusJob    = xi.job.GEO,
        bustPower   = 5,
        bustMod     = xi.mod.ENH_MAGIC_DURATION,
    },

    [xi.jobAbility.RUNEISTS_ROLL] =
    {
        effect      = xi.effect.RUNEISTS_ROLL,
        powers      = { 4, 6, 8, 25, 10, 12, 14, 2, 17, 20, 30 },
        phantomBase = 2,
        bonus       = 7,
        bonusJob    = xi.job.RUN,
        bustPower   = 10,
        bustMod     = xi.mod.MEVA,
    },

    [xi.jobAbility.BOLTERS_ROLL] =
    {
        effect      = xi.effect.BOLTERS_ROLL,
        powers      = { 6, 6, 16, 8, 8, 10, 10, 12, 4, 14, 20 },
        phantomBase = 4,
        bonus       = 0,
        bonusJob    = xi.job.NONE,
        bustPower   = 0,
        bustMod     = xi.mod.MOVE_SPEED_BOLTERS_ROLL,
    },

    [xi.jobAbility.CASTERS_ROLL] =
    {
        effect      = xi.effect.CASTERS_ROLL,
        powers      = { 6, 15, 7, 8, 9, 10, 5, 11, 12, 13, 20 },
        phantomBase = 3,
        bonus       = 10,
        bonusJob    = xi.job.NONE,
        bustPower   = 10,
        bustMod     = xi.mod.FASTCAST,
    },

    [xi.jobAbility.COURSERS_ROLL] =
    {
        effect      = xi.effect.COURSERS_ROLL,
        powers      = { 2, 3, 11, 4, 5, 6, 7, 8, 1, 10, 12 },
        phantomBase = 1,
        bonus       = 3,
        bonusJob    = xi.job.NONE,
        bustPower   = 0,
        bustMod     = xi.mod.NONE, -- no known bust penalty
        -- TODO: quantify Courser's Roll
    },

    [xi.jobAbility.BLITZERS_ROLL] =
    {
        effect      = xi.effect.BLITZERS_ROLL,
        powers      = { -2, -3, -4, -11, -5, -6, -7, -8, -1, -10, -12 },
        phantomBase = -1,
        bonus       = -3,
        bonusJob    = xi.job.NONE,
        bustPower   = 3,
        bustMod     = xi.mod.DELAYP,
    },

    [xi.jobAbility.TACTICIANS_ROLL] =
    {
        effect      = xi.effect.TACTICIANS_ROLL,
        powers      = { 10, 10, 10, 10, 30, 10, 10, 0, 20, 20, 40 },
        phantomBase = 2,
        bonus       = 10,
        bonusJob    = xi.job.NONE,
        bustPower   = 10,
        bustMod     = xi.mod.REGAIN,
    },

    [xi.jobAbility.ALLIES_ROLL] =
    {
        effect      = xi.effect.ALLIES_ROLL,
        powers      = { 2, 3, 20, 5, 7, 9, 11, 13, 15, 1, 25 },
        phantomBase = 1,
        bonus       = 5,
        bonusJob    = xi.job.NONE,
        bustPower   = 5,
        bustMod     = xi.mod.SKILLCHAINBONUS,
    },

    [xi.jobAbility.MISERS_ROLL] =
    {
        effect      = xi.effect.MISERS_ROLL,
        powers      = { 30, 50, 70, 90, 200, 110, 20, 130, 150, 170, 250 },
        phantomBase = 15,
        bonus       = 0,
        bonusJob    = xi.job.NONE,
        bustPower   = 0,
        bustMod     = xi.mod.SAVETP,
    },

    [xi.jobAbility.COMPANIONS_ROLL] =
    {
        effect      = xi.effect.COMPANIONS_ROLL,
        powers      = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 },
        phantomBase = 10,
        bonus       = 0,
        bonusJob    = xi.job.NONE,
        bustPower   = 0,
        bustMod     = xi.mod.NONE, -- no known bust penalty; buff applies to pet only
    },

    [xi.jobAbility.AVENGERS_ROLL] =
    {
        effect      = xi.effect.AVENGERS_ROLL,
        powers      = { 2, 2, 3, 12, 4, 5, 6, 1, 7, 9, 18 },
        phantomBase = 1,
        bonus       = 0,
        bonusJob    = xi.job.NONE,
        bustPower   = 6,
        bustMod     = xi.mod.COUNTER,
    },
}

xi.job_utils.corsair.quickDrawDataTable =
{
    [xi.jobAbility.FIRE_SHOT   ] = { cardAmmo = xi.item.FIRE_CARD,    element = xi.element.FIRE,    multiplier = 1.2, canDamage = true,  applyEffectId = 0                 },
    [xi.jobAbility.ICE_SHOT    ] = { cardAmmo = xi.item.ICE_CARD,     element = xi.element.ICE,     multiplier = 1.2, canDamage = true,  applyEffectId = 0                 },
    [xi.jobAbility.WIND_SHOT   ] = { cardAmmo = xi.item.WIND_CARD,    element = xi.element.WIND,    multiplier = 1.2, canDamage = true,  applyEffectId = 0                 },
    [xi.jobAbility.EARTH_SHOT  ] = { cardAmmo = xi.item.EARTH_CARD,   element = xi.element.EARTH,   multiplier = 1.2, canDamage = true,  applyEffectId = 0                 },
    [xi.jobAbility.THUNDER_SHOT] = { cardAmmo = xi.item.THUNDER_CARD, element = xi.element.THUNDER, multiplier = 1.2, canDamage = true,  applyEffectId = 0                 },
    [xi.jobAbility.WATER_SHOT  ] = { cardAmmo = xi.item.WATER_CARD,   element = xi.element.WATER,   multiplier = 1.2, canDamage = true,  applyEffectId = 0                 },
    [xi.jobAbility.LIGHT_SHOT  ] = { cardAmmo = xi.item.LIGHT_CARD,   element = xi.element.LIGHT,   multiplier = 1.0, canDamage = false, applyEffectId = xi.effect.SLEEP_I },
    [xi.jobAbility.DARK_SHOT   ] = { cardAmmo = xi.item.DARK_CARD,    element = xi.element.DARK,    multiplier = 1.5, canDamage = false, applyEffectId = xi.effect.NONE    }, -- Dispel
}

xi.job_utils.corsair.quickDrawEffectBoostTable =
{
    [xi.jobAbility.FIRE_SHOT] =
    {
        { effectId = xi.effect.BURN, capGlobal = 8 },
    },

    [xi.jobAbility.ICE_SHOT] =
    {
        { effectId = xi.effect.FROST,     capGlobal =  8 },
        { effectId = xi.effect.PARALYSIS, capGlobal = 30 },
    },

    [xi.jobAbility.WIND_SHOT] =
    {
        { effectId = xi.effect.CHOKE, capGlobal = 8 }, -- TODO: Determine if Wind Shot effects Defense Down
    },

    [xi.jobAbility.EARTH_SHOT] =
    {
        { effectId = xi.effect.RASP, capGlobal =    8 },
        { effectId = xi.effect.SLOW, capGlobal = 3300 },
    },

    [xi.jobAbility.THUNDER_SHOT] =
    {
        { effectId = xi.effect.SHOCK, capGlobal = 8 },
    },

    [xi.jobAbility.WATER_SHOT] =
    {
        { effectId = xi.effect.DROWN, capGlobal = 8 },
    },

    [xi.jobAbility.LIGHT_SHOT] =
    {
        { effectId = xi.effect.DIA, basePowerByTier = { [1] = 10, [3] = 15, [5] = 20, [7] = 25, [9] = 30 } },
    },

    [xi.jobAbility.DARK_SHOT] =
    {
        { effectId = xi.effect.BIO,       basePowerByTier = { [2] = 10, [4] = 15, [6] = 20, [8] = 25, [10] = 30 } },
        { effectId = xi.effect.BLINDNESS, capGlobal = 30                                                          },
    },
}

local rollEnhanceMods =
{
    [xi.jobAbility.CASTERS_ROLL   ] = xi.mod.ENHANCES_CASTERS_ROLL,
    [xi.jobAbility.COURSERS_ROLL  ] = xi.mod.ENHANCES_COURSERS_ROLL,
    [xi.jobAbility.BLITZERS_ROLL  ] = xi.mod.ENHANCES_BLITZERS_ROLL,
    [xi.jobAbility.TACTICIANS_ROLL] = xi.mod.ENHANCES_TACTICIANS_ROLL,
}

-----------------------------------
-- Local helper functions
-----------------------------------

local function corsairSetup(caster, ability, action, effect, job)
    local roll = math.randomInt(1, 6)

    caster:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
    caster:addStatusEffect(xi.effect.DOUBLE_UP_CHANCE, {
        power           = roll,
        duration        = 45,
        origin          = caster,
        subPower        = effect,
        tier            = job,
        sourceType      = xi.effectSourceType.CORSAIR_ROLL,
        sourceTypeParam = ability:getID(),
        silent          = true
    })

    caster:setLocalVar('corsairRollTotal', roll)
    caster:setLocalVar('corsairDuEffect', effect)
    action:info(caster:getID(), roll)

    local recastReduction = utils.clamp(caster:getMerit(xi.merit.PHANTOM_ROLL_RECAST) + caster:getMod(xi.mod.PHANTOM_RECAST), 0, 45)
    local recastTime      = ability:getRecast()

    -- While an XI roll is active, Phantom Roll recast is halved.
    if
        xi.job_utils.corsair.checkForElevenRoll(caster) and
        caster:numBustEffects() == 0
    then
        recastTime = math.floor(recastTime / 2)
    end

    -- https://wiki-ffo-jp.translate.goog/html/3347.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc (Near the middle)
    -- In short, it seems the minimum recast time is 15 seconds.
    action:setRecast(utils.clamp(recastTime - recastReduction, 15, 300))

    xi.job_utils.corsair.checkForJobBonus(caster, job)
end

-- Handle application of roll or bust effects on party members
local function applyCorsairEffect(caster, target, abilityId, power, subPower)
    local rollInfo = xi.job_utils.corsair.rollData[abilityId]
    if not rollInfo then
        return false
    end

    local effectId        = rollInfo.effect
    local sourceTypeParam = caster:getID()
    local numOfEffects    = 0
    local oldestRoll      = nil
    local oldestExpiry    = nil
    local upgradeEffect   = nil

    for _, effect in pairs(target:getStatusEffects()) do
        local selectedID   = effect:getEffectType()
        local isFromCaster = effect:getSourceTypeParam() == sourceTypeParam

        -- Target has an existing roll of the same type from this caster: determine upgrade or bust
        if
            isFromCaster and
            selectedID == effectId and
            effect:getSubPower() < subPower
        then
            -- Upgrade existing roll
            if subPower <= 11 then
                upgradeEffect = effect

            else
                -- Bust: only apply the bust effect on self-rolls and only when no XI roll is active.
                if
                    sourceTypeParam == target:getID() and
                    not xi.job_utils.corsair.checkForElevenRoll(target)
                then
                    target:addStatusEffect(xi.effect.BUST, {
                        power           = power,
                        duration        = 300 - caster:getMerit(xi.merit.BUST_DURATION),
                        subType         = rollInfo.bustMod,
                        subPower        = subPower,
                        sourceType      = effect:getSourceType(),
                        sourceTypeParam = sourceTypeParam,
                        origin          = caster,
                        silent          = true,
                    })
                    target:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
                end

                target:delStatusEffectSilent(effectId)

                return true
            end

            break
        end

        -- Count effects and track the oldest phantom roll as the eviction candidate.
        if
            (isFromCaster and effect:hasEffectFlag(xi.effectFlag.ROLL)) or
            (selectedID == xi.effect.BUST and sourceTypeParam == target:getID())
        then
            numOfEffects = numOfEffects + 1

            if selectedID ~= xi.effect.BUST then
                local effectExpiry = effect:getStartTime() + effect:getDuration() / 1000
                if
                    not oldestRoll or
                    effectExpiry < oldestExpiry
                then
                    oldestRoll   = effect
                    oldestExpiry = effectExpiry
                end
            end
        end
    end

    -- Determine slot and duration: upgrade in-place, claim a free slot, or evict the oldest roll.
    local addDuration = 300 + caster:getMerit(xi.merit.WINNING_STREAK) + caster:getMod(xi.mod.PHANTOM_DURATION) + caster:getJobPointLevel(xi.jp.PHANTOM_ROLL_DURATION) * 2
    local addSlot     = nil
    local addSilent   = true

    -- Upgrading an existing roll: Preserve the existing effect's slot and remaining duration.
    if upgradeEffect then
        target:delStatusEffectSilent(effectId)
        addDuration = upgradeEffect:getDuration() / 1000
        addSlot     = upgradeEffect:getEffectSlot()

    -- New roll when there is a free slot: Use the lowest available slot and the full duration.
    elseif numOfEffects < (caster:getMainJob() == xi.job.COR and 2 or 1) then
        addSlot     = utils.getLowestFreeSlot(target)

    -- Unique roll with no free slots: Evict the oldest existing roll
    elseif oldestRoll then
        target:delStatusEffect(oldestRoll:getEffectType())
        addSlot     = oldestRoll:getEffectSlot()
        addSilent   = false

    else
        return false
    end

    local effectParams =
    {
        power           = power,
        duration        = addDuration,
        subPower        = subPower,
        sourceType      = xi.effectSourceType.CORSAIR_ROLL,
        sourceTypeParam = sourceTypeParam,
        origin          = caster,
        silent          = addSilent,
        slot            = addSlot,
    }

    return target:addStatusEffect(effectId, effectParams)
end

-----------------------------------
-- Global helper functions
-----------------------------------

xi.job_utils.corsair.checkForElevenRoll = function(caster)
    local effects = caster:getStatusEffects()

    for _, effect in pairs(effects) do
        if
            effect:hasEffectFlag(xi.effectFlag.ROLL) and
            effect:getSubPower() == 11
        then
            return true
        end
    end

    return false
end

xi.job_utils.corsair.onRollEffectLose = function(player, effect)
    -- Ignore effect loss if COR is doubling up
    if player:getLocalVar('corsairApplyingRoll') == 1 then
        return
    end

    if
        player:hasStatusEffect(xi.effect.DOUBLE_UP_CHANCE) and
        player:getLocalVar('corsairDuEffect') == effect:getEffectType()
    then
        player:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
        player:setLocalVar('corsairDuEffect', 0)
    end
end

xi.job_utils.corsair.handleQuickDrawDamage = function(player, target, action, element, resist)
    -- Calculate Quick Draw damage - https://wiki.ffo.jp/html/3349.html TODO: QUICK_DRAW_TRIPLE_DAMAGE gear mod needs research
    local damage                 = 2 * player:getRangedDmg() + 2 * player:getJobPointLevel(xi.jp.QUICK_DRAW_EFFECT) + player:getMod(xi.mod.QUICK_DRAW_DMG)
    local deathPenaltyMultiplier = 1 + player:getMod(xi.mod.QUICK_DRAW_DMG_PERCENT) / 100
    local damageAdditiveBonus    = player:getMod(xi.mod.MAGIC_DAMAGE)
    local elementalStaffBonus    = xi.spells.damage.calculateElementalStaffBonus(player, element)
    local affinityMultiplier     = xi.spells.damage.calculateElementalAffinityBonus(player, element)
    local dayWeatherMultiplier   = xi.spells.damage.calculateDayAndWeather(player, element, false)
    local magicBonusDiff         = xi.spells.damage.calculateMagicBonusDiff(player, target, 0, 0, element, 0)

    -- Unconfirmed order.
    local sdtMultiplier          = xi.combat.damage.magicalElementSDT(target, element)
    local additionalResistTier   = xi.spells.damage.calculateAdditionalResistTier(player, target, element)
    local elementalAbsorption    = xi.spells.damage.calculateAbsorption(target, element, false)
    local elementalNullification = xi.spells.damage.calculateNullification(target, element, false, false)

    -- Apply multipliers and bonuses.
    damage = math.floor(damage * deathPenaltyMultiplier)
    damage = math.floor(damage + damageAdditiveBonus)
    damage = math.floor(damage * elementalStaffBonus)
    damage = math.floor(damage * affinityMultiplier)
    damage = math.floor(damage * dayWeatherMultiplier)
    damage = math.floor(damage * magicBonusDiff)
    damage = math.floor(damage * sdtMultiplier)
    damage = math.floor(damage * resist)
    damage = math.floor(damage * additionalResistTier)
    damage = math.floor(damage * elementalAbsorption)
    damage = math.floor(damage * elementalNullification)

    -- TODO: Investigate. Whats actually needed from this?
    damage = xi.ability.takeDamage(target, player, { targetTPMult = 0 }, true, damage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + element, xi.slot.RANGED, 1, 0, 0, 0, action, nil)

    return damage
end

xi.job_utils.corsair.handleQuickDrawEffectBoost = function(player, target, abilityId, multiplier)
    local effectData = xi.job_utils.corsair.quickDrawEffectBoostTable[abilityId]
    if not effectData then
        return
    end

    -- Gather eligible effects that have not yet been boosted.
    local effects = {}
    for _, entryTable in ipairs(effectData) do
        local effectChecked = target:getStatusEffect(entryTable.effectId)

        if effectChecked then
            local eligible = false

            -- Check for Dia/Bio.
            if entryTable.basePowerByTier then
                local basePower = entryTable.basePowerByTier[effectChecked:getTier()]
                eligible        = basePower and effectChecked:getSubPower() <= basePower

            -- Check for all other eligible effects
            else
                eligible = effectChecked:getPower() < entryTable.capGlobal
            end

            if eligible then
                table.insert(effects, { effect = effectChecked, entry = entryTable })
            end
        end
    end

    -- Early return: No effect can be boosted, either because it's capped or isn't present.
    if #effects <= 0 then
        return
    end

    -- Select effect entry from table and fetch it's content.
    local selected = effects[math.randomInt(1, #effects)]
    local effect   = selected.effect
    local entry    = selected.entry

    -- Fetch effect data.
    local effectId        = effect:getEffectType()
    local effectPower     = effect:getPower()
    local effectTick      = effect:getTick() / 1000
    local effectDuration  = effect:getDuration() / 1000
    local effectSubPower  = effect:getSubPower()
    local effectSubType   = effect:getSubType()
    local effectTier      = effect:getTier()
    local effectStartTime = effect:getStartTime()
    local effectOriginID  = effect:getOriginID()

    -- Apply boost to Dia or Bio effects. They can only be boosted once. "Cannot be stacked."
    if entry.basePowerByTier then
        -- TODO: Determine power effect of Bio. Current retail bug with Dark Shot removes the DoT effect from Bio currently.
        if effectId == xi.effect.DIA then
            effectPower = effectPower + 1
        end

        effectSubPower = effectSubPower + math.floor(100 * 28 / 1024) -- TODO: Change ATTP, DEFP and similar mods from base 100 to base 10k

    -- Apply boost to all other eligible effects.
    else
        if effectId >= xi.effect.BURN and effectId <= xi.effect.DROWN then
            effectPower = math.min(effectPower + 2, entry.capGlobal)
        else
            effectPower = math.min(effectPower * multiplier, entry.capGlobal)
        end
    end

    -- Remove the existing effect and reapply it with the new power/subPower values.
    target:delStatusEffectSilent(effectId)

    local params =
    {
        power    = effectPower,
        tick     = effectTick,
        duration = effectDuration,
        subPower = effectSubPower,
        subType  = effectSubType,
        tier     = effectTier,
        origin   = player,
    }

    target:addStatusEffect(effectId, params)

    -- Update the start time and origin ID of the new effect to match the original effect.
    local newEffect = target:getStatusEffect(effectId)
    if newEffect then
        newEffect:setStartTime(effectStartTime)
        newEffect:setOriginID(effectOriginID)
    end
end

-- Sets local var if party contains specified job
xi.job_utils.corsair.checkForJobBonus = function(caster, job)
    if job == xi.job.NONE then
        caster:setLocalVar('corsairRollBonus', 0)
        return
    end

    if caster:hasPartyJob(job) then
        caster:setLocalVar('corsairRollBonus', 1)
        return
    end

    if math.randomInt(1, 100) <= caster:getMod(xi.mod.JOB_BONUS_CHANCE) then
        caster:setLocalVar('corsairRollBonus', 1)
        return
    end

    caster:setLocalVar('corsairRollBonus', 0)
end

-- in_ability == current_ability if not using doubleup. current_ability is used to set the message whether you're using a doubleup or not.
xi.job_utils.corsair.applyRoll = function(caster, target, inAbility, total, isDoubleup, currentAbility)
    local abilityId   = inAbility:getID()
    local rollInfo    = xi.job_utils.corsair.rollData[abilityId]
    local effectpower = total >= 12 and rollInfo.bustPower or rollInfo.powers[total]    -- Get roll or bust power values
    local enhanceMod  = rollEnhanceMods[abilityId]                                      -- Check for roll enhancement gear mod specific to the rolled ability
    local doBonus     = enhanceMod and math.randomInt(1, 100) <= caster:getMod(enhanceMod) -- Chance to enhance roll based on gear mod

    -- Apply roll bonus if matching job or gear mod triggers
    if
        (rollInfo.bonusJob == xi.job.NONE and doBonus) or
        (caster:getLocalVar('corsairRollBonus') == 1 and total <= 11)
    then
        effectpower = effectpower + rollInfo.bonus
    end

    -- Apply Additional Phantom Roll+ Buff
    local phantomMult = caster:getMaxGearMod(xi.mod.PHANTOM_ROLL)
    effectpower       = effectpower + rollInfo.phantomBase * phantomMult

    -- Effect Power varies depending on COR level (Main vs Sub)
    local actorLevel  = utils.getActiveJobLevel(caster, xi.job.COR)
    local targetLevel = target:getMainLvl()

    -- Level correction.
    if actorLevel < targetLevel then
        effectpower = effectpower * actorLevel / targetLevel
    end

    caster:setLocalVar('corsairApplyingRoll', 1)

    -- Handle messages: No effect or otherwise prevented.
    if not applyCorsairEffect(caster, target, abilityId, effectpower, total) then
        if caster:getID() == target:getID() then                  -- dead code? you can't roll if the same roll is already active. There is no known buff that would prevent a corsair roll.
            currentAbility:setMsg(xi.msg.basic.ROLL_MAIN_FAIL)    -- no effect for the COR rolling if they had the buff already
        else
            currentAbility:setMsg(xi.msg.basic.NO_EFFECT)         -- no effect for the target if they had the buff already. Testing in retail shows it's _not_ xi.msg.basic.ROLL_SUB_FAIL if the roll is already active. There is no known buff that would prevent a corsair roll, so maybe this would be used there if there were one?
        end

    -- Handle messages: Bust.
    elseif total > 11 then
        if caster:getID() == target:getID() then
            currentAbility:setMsg(xi.msg.basic.DOUBLEUP_BUST)     -- bust message for the COR rolling
        else
            currentAbility:setMsg(xi.msg.basic.DOUBLEUP_BUST_SUB) -- bust message for the target getting the roll
        end

    -- Handle messages: Success
    else
        if caster:getID() == target:getID() then
            if isDoubleup then
                currentAbility:setMsg(xi.msg.basic.DOUBLEUP)      -- success on doubleup for COR has different message than from just using Phantom Roll
            else
                currentAbility:setMsg(xi.msg.basic.ROLL_MAIN)     -- success message for the COR rolling the first time
            end
        else
            currentAbility:setMsg(xi.msg.basic.ROLL_SUB)          -- message for the target getting the roll. Always the same, even if it's the COR's first roll.
        end
    end

    caster:setLocalVar('corsairApplyingRoll', 0)

    return total
end

-----------------------------------
-- Ability Check functions
-----------------------------------

-- Called by all indivi Phantom Rolls' onAbilityCheck
-- Prevent using a roll if the same roll is already active, or if the player has too many busts.
xi.job_utils.corsair.onRollAbilityCheck = function(player, target, ability)
    local abilityId = ability:getID()
    local numBusts  = player:numBustEffects()
    local effectId  = xi.job_utils.corsair.rollData[abilityId].effect
    local maxRolls  = player:getMainJob() == xi.job.COR and 2 or 1

    if player:hasStatusEffect(effectId) then
        return xi.msg.basic.ROLL_ALREADY_ACTIVE, 0
    elseif numBusts >= maxRolls then
        return xi.msg.basic.CANNOT_PERFORM, 0
    end

    return 0, 0
end

xi.job_utils.corsair.checkDoubleUp = function(player, target, ability)
    if not player:hasStatusEffect(xi.effect.DOUBLE_UP_CHANCE) then
        return xi.msg.basic.NO_ELIGIBLE_ROLL, 0
    else
        return 0, 0
    end
end

xi.job_utils.corsair.checkFold = function(player)
    if player:numBustEffects() > 0 then
        return 0, 0
    end

    if player:countEffectWithFlag(xi.effectFlag.ROLL) == 0 then
        return xi.msg.basic.CANNOT_PERFORM, 0
    end

    for _, effect in pairs(player:getStatusEffects()) do
        if
            effect:hasEffectFlag(xi.effectFlag.ROLL) and
            effect:getSourceTypeParam() == player:getID()
        then
            return 0, 0
        end
    end

    return xi.msg.basic.CANNOT_PERFORM, 0
end

xi.job_utils.corsair.checkQuickDraw = function(player, ability)
    local data = xi.job_utils.corsair.quickDrawDataTable[ability:getID()]
    if not data then
        return xi.msg.basic.CANNOT_PERFORM, 0
    end

    if
        player:getWeaponSkillType(xi.slot.RANGED) ~= xi.skill.MARKSMANSHIP or
        player:getWeaponSkillType(xi.slot.AMMO) ~= xi.skill.MARKSMANSHIP
    then
        return xi.msg.basic.NO_RANGED_WEAPON, 0
    end

    if
        not player:hasItem(data.cardAmmo, xi.inventoryLocation.INVENTORY) and
        not player:hasItem(xi.item.TRUMP_CARD, xi.inventoryLocation.INVENTORY)
    then
        return xi.msg.basic.CANNOT_PERFORM, 0
    end

    return 0, 0
end

-----------------------------------
-- Ability Use functions
-----------------------------------

xi.job_utils.corsair.useWildCard = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        local roll = math.randomInt(1, 6)
        caster:setLocalVar('corsairRollTotal', roll)
        action:info(caster:getID(), roll)
    end

    local total = caster:getLocalVar('corsairRollTotal')

    caster:doWildCard(target, total)
    ability:setMsg(xi.msg.basic.WILD_CARD_BASE + math.floor((total - 1) / 2) * 2)
    action:setAnimation(target:getID(), 132 + total - 1)

    return total
end

-- Called by Phantom Rolls' onUseAbility
xi.job_utils.corsair.onRollUseAbility = function(caster, target, ability, action)
    local abilityId = ability:getID()
    local rollInfo  = xi.job_utils.corsair.rollData[abilityId]
    local effectId  = rollInfo.effect
    local bonusJob  = rollInfo.bonusJob

    if caster:getID() == target:getID() then
        corsairSetup(caster, ability, action, effectId, bonusJob)
    end

    return xi.job_utils.corsair.applyRoll(caster, target, ability, caster:getLocalVar('corsairRollTotal'), false, ability)
end

xi.job_utils.corsair.useDoubleUp = function(caster, target, ability, action)
    if caster:getID() == target:getID() then -- the COR handles all the calculations
        local duEffect = caster:getStatusEffect(xi.effect.DOUBLE_UP_CHANCE)
        local prevRoll = caster:getStatusEffect(duEffect:getSubPower())
        local roll     = prevRoll:getSubPower()
        local job      = duEffect:getTier()

        caster:setLocalVar('corsairActiveRoll', duEffect:getSourceTypeParam())

        local snakeEye = caster:getStatusEffect(xi.effect.SNAKE_EYE)

        if snakeEye then
            if roll >= 5 and math.randomInt(1, 100) < snakeEye:getPower() then
                roll = 11
            else
                roll = roll + 1
            end

            caster:delStatusEffect(xi.effect.SNAKE_EYE)
        else
            roll = roll + math.randomInt(1, 6)
        end

        if roll >= 12 then -- bust
            roll = 12
            caster:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
        end

        if roll == 11 then
            caster:resetRecast(xi.recast.ABILITY, xi.recastID.PHANTOM_ROLL)
        end

        caster:setLocalVar('corsairRollTotal', roll)
        action:info(caster:getID(), roll - prevRoll:getSubPower())
        xi.job_utils.corsair.checkForJobBonus(caster, job)
    end

    local total       = caster:getLocalVar('corsairRollTotal')
    local activeRoll  = caster:getLocalVar('corsairActiveRoll')
    local prevAbility = GetAbility(activeRoll)

    if prevAbility then -- Apply rolls to target(s), including the COR
        action:actionID(prevAbility:getID())

        total = xi.job_utils.corsair.applyRoll(caster, target, prevAbility, total, true, ability)

        if total > 11 then
            action:setAnimation(target:getID(), 98) -- 98 is bust anim for all rolls
        else
            action:setAnimation(target:getID(), prevAbility:getAnimation())
        end

        return total
    end
end

xi.job_utils.corsair.useElementalShot = function(actor, target, ability, action)
    local abilityId = ability:getID()

    -- Fetch specific ability data.
    local data = xi.job_utils.corsair.quickDrawDataTable[abilityId]
    if not data then
        return
    end

    -- Handle card consumption.
    if not actor:delItem(data.cardAmmo, 1) then
        actor:delItem(xi.item.TRUMP_CARD, 1)
    end

    -- Handle recast.
    action:setRecast(math.max(0, action:getRecast() - actor:getMod(xi.mod.QUICK_DRAW_RECAST)))

    -- Handle claim.
    target:updateClaim(actor)

    -- Calculate resist rate.
    local bonusAcc = actor:getMerit(xi.merit.QUICK_DRAW_ACCURACY) + actor:getMod(xi.mod.QUICK_DRAW_MACC)
    local resist   = xi.combat.magicHitRate.calculateResistRate(actor, target, 0, xi.skill.MARKSMANSHIP, 0,  data.element, xi.mod.AGI, 0, bonusAcc)

    -- Handle damage.
    local damage = 0
    if data.canDamage then
        damage = xi.job_utils.corsair.handleQuickDrawDamage(actor, target, action, data.element, resist)
    end

    if damage > 0 then
        actor:addTP(xi.combat.tp.getSingleRangedHitTPReturn(actor))
        actor:trySkillUp(xi.skill.MARKSMANSHIP, target:getMainLvl())
    end

    -- Handle effect boost.
    xi.job_utils.corsair.handleQuickDrawEffectBoost(actor, target, abilityId, data.multiplier)

    -- Handle effect application.
    if data.applyEffectId > 0 then
        if
            xi.data.statusEffect.isTargetImmune(target, data.applyEffectId, data.element) or
            xi.data.statusEffect.isTargetResistant(actor, target, data.applyEffectId) or
            not xi.data.statusEffect.isResistRateSuccessfull(data.applyEffectId, resist, 0)
        then
            ability:setMsg(xi.msg.basic.JA_MISS_2)
            return data.applyEffectId
        end

        -- Light shot.
        if data.applyEffectId == xi.effect.SLEEP_I then
            if target:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = math.floor(90 * resist), subPower = data.element, origin = actor }) then
                ability:setMsg(xi.msg.basic.JA_ENFEEB_IS)
            else
                ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            end

            return xi.effect.SLEEP_I

        -- Dark shot.
        else
            ability:setMsg(xi.msg.basic.JA_REMOVE_EFFECT_2)

            local dispelledEffect = target:dispelStatusEffect()
            if dispelledEffect == xi.effect.NONE then
                ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            end

            return dispelledEffect
        end
    end

    return damage
end

xi.job_utils.corsair.useSnakeEye = function(player, action)
    player:addStatusEffect(xi.effect.SNAKE_EYE, { power = player:getMerit(xi.merit.SNAKE_EYE) - 10, duration = 60, origin = player })

    return xi.effect.SNAKE_EYE
end

xi.job_utils.corsair.useFold = function(player, action)
    local newestBust = nil
    local newestRoll = nil
    local bustExpiry = 0
    local rollExpiry = 0

    -- Pick the bust or roll with the longest remaining duration
    for _, effect in pairs(player:getStatusEffects()) do
        local effectType = effect:getEffectType()
        local expiry     = effect:getStartTime() + effect:getDuration() / 1000

        if
            effectType == xi.effect.BUST and
            (newestBust == nil or expiry > bustExpiry)
        then
            newestBust = effect
            bustExpiry = expiry

        elseif
            effect:hasEffectFlag(xi.effectFlag.ROLL) and
            effect:getSourceTypeParam() == player:getID() and
            (newestRoll == nil or expiry > rollExpiry)
        then
            newestRoll = effect
            rollExpiry = expiry
        end
    end

    -- Bust takes priority over Phantom Rolls.
    local selected = newestBust or newestRoll

    if selected ~= nil then
        player:delStatusEffect(selected:getEffectType())
        player:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)

        -- Each merit level adds +10% chance to reset Phantom Roll recast.
        if math.randomInt(1, 100) <= player:getMerit(xi.merit.FOLD) then
            player:resetRecast(xi.recast.ABILITY, xi.recastID.PHANTOM_ROLL)
        end
    end

    return xi.msg.basic.NONE
end

-- TODO: Binding does not exist, implement this (old code remains)
xi.job_utils.corsair.useCuttingCards = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        local roll = math.randomInt(1, 6)

        caster:setLocalVar('corsairRollTotal', roll)
        action:info(caster:getID(), roll)
    end

    local total = caster:getLocalVar('corsairRollTotal')

    ability:setMsg(435 + math.floor((total - 1) / 2) * 2)
    action:setAnimation(target:getID(), 132 + (total) - 1)

    return total
end
