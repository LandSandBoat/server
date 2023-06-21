-----------------------------------
-- Black Mage Job Utilities
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.black_mage = xi.job_utils.black_mage or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.black_mage.checkManafont = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

xi.job_utils.black_mage.checkSubtleSorcery = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.black_mage.useCascade = function(player, target, ability)
    player:addStatusEffect(xi.effect.CASCADE, 1, 0, 60)
end

xi.job_utils.black_mage.useElementalSeal = function(player, target, ability)
    player:addStatusEffect(xi.effect.ELEMENTAL_SEAL, 1, 0, 60)
end

xi.job_utils.black_mage.useEnmityDouse = function(player, target, ability)
    if target:isMob() then
        target:setCE(player, 1)
        target:setVE(player, 0)
    end
end

xi.job_utils.black_mage.useManafont = function(player, target, ability)
    player:addStatusEffect(xi.effect.MANAFONT, 1, 0, 60)
end

xi.job_utils.black_mage.useManaWall = function(player, target, ability)
    player:addStatusEffect(xi.effect.MANA_WALL, 1, 0, 300)
end

xi.job_utils.black_mage.useManawell = function(player, target, ability)
    target:addStatusEffect(xi.effect.MANAWELL, 1, 0, 60)
end

xi.job_utils.black_mage.useSubtleSorcery = function(player, target, ability)
    player:addStatusEffect(xi.effect.SUBTLE_SORCERY, 1, 0, 60)
end
