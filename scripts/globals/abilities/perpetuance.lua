-----------------------------------
-- Ability: Perpetuance
-- Increases the enhancement effect duration of your next white magic spell.
-- Obtained: Scholar Level 87
-- Recast Time: Stratagem Charge
-- Duration: 00:01:00 or first white Enhancing Magic cast, whichever first
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
    if player:hasStatusEffect(xi.effect.PERPETUANCE) then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.PERPETUANCE, 1, 0, 60)

    return xi.effect.PERPETUANCE
end

return abilityObject
