-----------------------------------
-- Ability: Addendum: Black
-- Allows access to additional Black Magic spells while using Dark Arts.
-- Obtained: Scholar Level 30
-- Recast Time: Stratagem Charge
-- Duration: 2 hours
--
-- Level   |Charges |Recharge Time per Charge
-- -----   -------- ---------------
-- 10      |1       |4:00 minutes
-- 30      |2       |2:00 minutes
-- 50      |3       |1:20 minutes
-- 70      |4       |1:00 minute
-- 90      |5       |48 seconds
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.ADDENDUM_BLACK) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:delStatusEffectSilent(xi.effect.LIGHT_ARTS)
    player:delStatusEffectSilent(xi.effect.ADDENDUM_WHITE)
    player:delStatusEffectSilent(xi.effect.DARK_ARTS)

    local effectbonus = player:getMod(xi.mod.DARK_ARTS_EFFECT)
    local helixbonus  = 0

    if player:getMainJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    player:addStatusEffectEx(xi.effect.ADDENDUM_BLACK, xi.effect.ADDENDUM_BLACK, effectbonus, 0, 7200, 0, helixbonus, true)

    return xi.effect.ADDENDUM_BLACK
end

return abilityObject
