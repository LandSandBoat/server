-----------------------------------
-- Module: Ninja Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_ninja'
local m = Module:new(moduleName)

-- Register RoV reverts only before RoV content is enabled.
if not xi.module.isContentEnabled('ROV') then
    -- Yonin: Remove extra enmity bonus from Utsusemi spells and Yonin merits
    m:addOverride('xi.effects.yonin.onEffectGain', function(target, effect)
        effect:addMod(xi.mod.ACC, -effect:getPower())
        effect:addMod(xi.mod.NINJA_TOOL, effect:getPower())
        effect:addMod(xi.mod.ENMITY, effect:getPower())
    end)
end

-- Register SoA reverts only before SoA content is enabled.
if not xi.module.isContentEnabled('SOA') then
    -- Sange: Reverts to Utsusemi based barrage style ranged attack
    -- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
    m:addOverride('xi.job_utils.ninja.useSange', function(player, target, ability, action)
        local meritReduction = player:getMerit(xi.merit.SANGE) - 150
        ability:setRecast(math.max(0, ability:getRecast() - meritReduction))

        -- Apply Sange effect (shadows are consumed when the ranged attack fires)
        player:addStatusEffect(xi.effect.SANGE, { duration = 60, origin = player })

        return xi.effect.SANGE
    end)

    -- Sange effect: Replace 100% daken with multi-hit ranged mod
    m:addOverride('xi.effects.sange.onEffectGain', function(target, effect)
        effect:addMod(xi.mod.SANGE_MULTI_HIT, 1)
    end)

    -- TODO: Detection Spell Durations
    -- Source: https://forum.square-enix.com/ffxi/threads/39564-Jan-21-2014-%28JST%29-Version-Update
    --   Tonko Ichi:  420 seconds -> 180 seconds
    --   Tonko Ni:    600 seconds -> 300 seconds
    --   Monomi Ichi: 420 seconds -> 180 seconds
end

-- Register WOTG reverts only before WOTG content is enabled.
if not xi.module.isContentEnabled('WOTG') then
    -- Mijin Gakure: Now applies weakness and normal HP gain on raise
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/20/2009)
    m:addOverride('xi.job_utils.ninja.useMijinGakure', function(player, target, ability, action)
        local dmg        = math.floor(player:getHP() * 0.8)
        local resist     = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, 0, xi.element.NONE, xi.mod.INT, 0, 0)
        local tmdaFactor = xi.combat.damage.calculateDamageAdjustment(target, false, true, false, false)
        local jpFactor   = 1 + player:getJobPointLevel(xi.jp.MIJIN_GAKURE_EFFECT) * 0.03

        dmg = math.floor(dmg * resist)
        dmg = math.floor(dmg * tmdaFactor)
        dmg = math.floor(dmg * jpFactor)
        dmg = utils.handleStoneskin(target, dmg)

        target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
        player:setHP(0)

        return dmg
    end)
end

-- Return a real module only when a content gate registered overrides.
-- Otherwise return a data-only table to avoid a "No overrides found" loader warning.
if #m.overrides > 0 then
    return m
end

return { name = moduleName }
