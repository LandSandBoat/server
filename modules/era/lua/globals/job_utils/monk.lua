-----------------------------------
-- Module: Monk Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_monk'

-- If RoV or later is enabled, no changes.
if xi.module.isContentEnabled('ROV') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-- Focus: Revert to flat +20 ACC only
m:addOverride('xi.effects.focus.onEffectGain', function(target, effect)
    local bonusPower = effect:getPower()

    effect:addMod(xi.mod.ACC, 20 + bonusPower)
end)

-- Dodge: Revert to flat +20 EVA only
m:addOverride('xi.effects.dodge.onEffectGain', function(target, effect)
    local bonusPower = effect:getPower()

    effect:addMod(xi.mod.EVA, 20 + bonusPower)
end)

-- Focus: Revert duration from 30 to 120 seconds
m:addOverride('xi.job_utils.monk.useFocus', function(player, target, ability)
    local focusMod = target:getMod(xi.mod.FOCUS_EFFECT)
    player:addStatusEffect(xi.effect.FOCUS, { power = focusMod, duration = 120, origin = player })

    return xi.effect.FOCUS
end)

-- Dodge: Revert duration from 30 to 120 seconds
m:addOverride('xi.job_utils.monk.useDodge', function(player, target, ability)
    local dodgeMod = target:getMod(xi.mod.DODGE_EFFECT)
    player:addStatusEffect(xi.effect.DODGE, { power = dodgeMod, duration = 120, origin = player })

    return xi.effect.DODGE
end)

-- Chakra: Revert to VIT * 2 healing only
m:addOverride('xi.job_utils.monk.useChakra', function(player, target, ability)
    local chakraRemoval = player:getMod(xi.mod.CHAKRA_REMOVAL)

    -- Status effect removal (unchanged)
    local chakraStatusEffects =
    {
        POISON    = 0,    -- Removed by default
        BLINDNESS = 0,    -- Removed by default
        PARALYSIS = 1,
        DISEASE   = 2,
        PLAGUE    = 4,
    }

    for k, v in pairs(chakraStatusEffects) do
        if bit.band(chakraRemoval, v) == v then
            player:delStatusEffect(xi.effect[k])
        end
    end

    local chakraMultiplier  = 1 + player:getMod(xi.mod.CHAKRA_MULT) / 100
    local maxRecoveryAmount = (player:getStat(xi.mod.VIT) * 2) * chakraMultiplier
    local recoveryAmount    = math.min(player:getMaxHP() - player:getHP(), maxRecoveryAmount)

    player:setHP(player:getHP() + recoveryAmount)

    local merits = player:getMerit(xi.merit.INVIGORATE)
    if merits > 0 then
        if player:hasStatusEffect(xi.effect.REGEN) then
            player:delStatusEffect(xi.effect.REGEN)
        end

        player:addStatusEffect(xi.effect.REGEN, { power = 10, duration = merits, origin = player, tier = 1 })
    end

    return recoveryAmount
end)

-- Revert Footwork to original June 2008 implementation
-- Source: https://wiki.ffo.jp/html/15342.html
-- TODO:
--   Normal attacks replaced with kicks only
--   Max attacks per round capped at 2
--   Special subtle blow that calculates enemy TP gain as if Monk's delay is 240
--   Hundred Fists disables Store TP and Attack bonuses from Footwork
-- m:addOverride('xi.job_utils.monk.useFootwork', function(player, target, ability)
--     -- Pre-RoV: base kick damage of 20 only, no weapon damage added
--     local kickDmg        = 20
--     local kickAttPercent = 25 + player:getMod(xi.mod.FOOTWORK_ATT_BONUS)

--     -- Duration changed from 60 seconds to 300 seconds (5 minutes)
--     player:addStatusEffect(xi.effect.FOOTWORK, { power = kickDmg, duration = 300, origin = player, subPower = kickAttPercent })

--     return xi.effect.FOOTWORK
-- end)

-- m:addOverride('xi.effects.footwork.onEffectGain', function(target, effect)
--     -- Kick damage: bare-hand D + 20 (passed as effect power, no weapon damage)
--     effect:addMod(xi.mod.KICK_DMG, effect:getPower())
--     effect:addMod(xi.mod.STORETP, 180)
--     effect:addMod(xi.mod.HASTE_MAGIC, -6000)
-- end)

return m
