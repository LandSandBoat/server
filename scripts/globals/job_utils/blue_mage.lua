-----------------------------------
-- Blue Mage Job Utilities
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.blue_mage = xi.job_utils.blue_mage or {}
-----------------------------------

-----------------------------------
-- Ability Check Functions
-----------------------------------

xi.job_utils.blue_mage.checkAzureLore = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

xi.job_utils.blue_mage.checkBurstAffinity = function(player, target, ability)
    return 0, 0
end

xi.job_utils.blue_mage.checkChainAffinity = function(player, target, ability)
    return 0, 0
end

xi.job_utils.blue_mage.checkDiffusion = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.DIFFUSION) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end

    return 0, 0
end

xi.job_utils.blue_mage.checkEfflux = function(player, target, ability)
    return 0, 0
end

xi.job_utils.blue_mage.checkUnbridledWisdom = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

xi.job_utils.blue_mage.checkUnbridledLearning = function(player, target, ability)
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------

xi.job_utils.blue_mage.useAzureLore = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.AZURE_LORE, 1, 0, 30)
end

xi.job_utils.blue_mage.useBurstAffinity = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.BURST_AFFINITY, 1, 0, 30)
    return xi.effect.BURST_AFFINITY
end

xi.job_utils.blue_mage.useChainAffinity = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.CHAIN_AFFINITY, 1, 0, 30)
    return xi.effect.CHAIN_AFFINITY
end

xi.job_utils.blue_mage.useDiffusion = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.DIFFUSION, 1, 0, 60)
    return xi.effect.DIFFUSION
end

xi.job_utils.blue_mage.useEfflux = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.EFFLUX, 16, 1, 60)
end

xi.job_utils.blue_mage.useUnbridledWisdom = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.UNBRIDLED_WISDOM, 16, 1, 30)
end

xi.job_utils.blue_mage.useUnbridledLearning = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.UNBRIDLED_LEARNING, 16, 1, 60)
end
