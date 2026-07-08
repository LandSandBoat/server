-----------------------------------
-- Module: Dark Knight Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_dark_knight'
local m = Module:new(moduleName)

-----------------------------------
-- Seekers of Adoulin Era
-----------------------------------

-- Register SoA reverts only before SoA content is enabled.
if not xi.module.isContentEnabled('SOA') then
    -- Last Resort: Reduces attack bonus from 25% to 15%
    -- Source: https://forum.square-enix.com/ffxi/threads/46976-May-14-2015-%28JST%29-Version-Update
    m:addOverride('xi.effects.last_resort.onEffectGain', function(target, effect)
        local targetMerit = target:getMerit(xi.merit.LAST_RESORT_EFFECT)

        effect:addMod(xi.mod.ATTP, 15 + targetMerit)
        effect:addMod(xi.mod.RATTP, 15 + targetMerit)
        effect:addMod(xi.mod.DEFP, -15 - targetMerit)
        effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))
    end)
end

-----------------------------------
-- Abyssea Era
-----------------------------------

-- Register Abyssea reverts only before Abyssea content is enabled.
if not xi.module.isContentEnabled('ABYSSEA') then
    -- Arcane Circle: Revert duration from 3 minutes to 1 minute
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
    m:addOverride('xi.job_utils.dark_knight.useArcaneCircle', function(player, target, ability)
        local duration = 60 + player:getMod(xi.mod.ARCANE_CIRCLE_DURATION)
        local power    = 15

        if player:getMainJob() ~= xi.job.DRK then
            power = 5
        end

        power = power + player:getMod(xi.mod.ARCANE_CIRCLE_POTENCY)

        target:addStatusEffect(xi.effect.ARCANE_CIRCLE, { power = power, duration = duration, origin = player })

        return xi.effect.ARCANE_CIRCLE
    end)

    -- Last Resort: Revert duration from 3 minutes to 30 seconds
    m:addOverride('xi.job_utils.dark_knight.useLastResort', function(player, target, ability)
        player:addStatusEffect(xi.effect.LAST_RESORT, { duration = 30, origin = player })

        return xi.effect.LAST_RESORT
    end)

    -- Dark Seal: Remove extra duration and cast speed from merits
    m:addOverride('xi.effects.dark_seal.onEffectGain',  function(target, effect)
        -- Overwrites
        target:delStatusEffectSilent(xi.effect.DIVINE_EMBLEM)
        target:delStatusEffectSilent(xi.effect.DIVINE_SEAL)
        target:delStatusEffectSilent(xi.effect.ELEMENTAL_SEAL)
    end)

    -- Dark Seal: Apply merit recast reduction
    m:addOverride('xi.job_utils.dark_knight.useDarkSeal', function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.DARK_SEAL) - 150
        action:setRecast(action:getRecast() - recastReduction)

        player:addStatusEffect(xi.effect.DARK_SEAL, { power = 1, duration = 60, origin = player })

        return xi.effect.DARK_SEAL
    end)

    -- Diabolic Eye: Remove extra duration and potency from merits and apply merit recast reduction
    m:addOverride('xi.job_utils.dark_knight.useDiabolicEye', function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.DIABOLIC_EYE) - 150
        action:setRecast(action:getRecast() - recastReduction)

        player:addStatusEffect(xi.effect.DIABOLIC_EYE, { power = 20, duration = 180, origin = player })

        return xi.effect.DIABOLIC_EYE
    end)
end

-----------------------------------
-- Wings of the Goddess Era
-----------------------------------

-- Expansion settings are cumulative: if WOTG is enabled, COP and TOAU are enabled too.
-- Register WOTG reverts only before WOTG content is enabled.
if not xi.module.isContentEnabled('WOTG') then
    -- Arcane Circle: Removes WotG resist/defense/attack circle mods
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/20/2009)
    m:addOverride('xi.effects.arcane_circle.onEffectGain', function(target, effect)
        effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
    end)
end

-- Return a real module only when a content gate registered overrides.
-- Otherwise return a data-only table to avoid a "No overrides found" loader warning.
if #m.overrides > 0 then
    return m
end

return { name = moduleName }
