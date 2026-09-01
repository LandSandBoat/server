-----------------------------------
-- Module: Ninja Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_ninja')

-- Yonin: Remove extra enmity bonus from Utsusemi spells and Yonin merits
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.effects.yonin.onEffectGain', {
    [xi.expansion.ROV] = function(target, effect)
        effect:addMod(xi.mod.ACC, -effect:getPower())
        effect:addMod(xi.mod.NINJA_TOOL, effect:getPower())
        effect:addMod(xi.mod.ENMITY, effect:getPower())
    end,
})

-- Sange: Reverts to Utsusemi based barrage style ranged attack
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
m:addOverrideByEra('xi.job_utils.ninja.useSange', {
    [xi.expansion.SOA] = function(player, target, ability, action)
        local meritReduction = player:getMerit(xi.merit.SANGE) - 150
        action:setRecast(math.max(0, action:getRecast() - meritReduction))

        -- Apply Sange effect (shadows are consumed when the ranged attack fires)
        player:addStatusEffect(xi.effect.SANGE, { duration = 60, origin = player })

        return xi.effect.SANGE
    end,
})

-- Sange effect: Replace 100% daken with multi-hit ranged mod
m:addOverrideByEra('xi.effects.sange.onEffectGain', {
    [xi.expansion.SOA] = function(target, effect)
        effect:addMod(xi.mod.SANGE_MULTI_HIT, 1)
    end,
})

-- Mijin Gakure: Now applies weakness and normal HP gain on raise
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/20/2009)
m:addOverrideByEra('xi.job_utils.ninja.useMijinGakure', {
    [xi.expansion.WOTG] = function(player, target, ability, action)
        local dmg = super(player, target, ability, action)

        player:die({ mijin = false })

        return dmg
    end,
})
