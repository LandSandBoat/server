-----------------------------------
-- Ability: Dancer's Roll
-- Grants Regen status to party members within area of effect
-- Optimal Job: Dancer
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 61
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |No DNC              |With DNC
-- --------    ----------           ----------
-- 1           |3HP/Tick            |7HP/Tick
-- 2           |4HP/Tick            |8HP/Tick
-- 3           |12HP/Tick           |16HP/Tick
-- 4           |5HP/Tick            |9HP/Tick
-- 5           |6HP/Tick            |10HP/Tick
-- 6           |7HP/Tick            |11HP/Tick
-- 7           |1HP/Tick            |5HP/Tick
-- 8           |8HP/Tick            |12HP/Tick
-- 9           |9HP/Tick            |13HP/Tick
-- 10          |10HP/Tick           |14HP/Tick
-- 11          |16HP/Tick           |20HP/Tick
-- 12+         |-4hp(regen)/Tick    |-4hp(regen)/Tick
-- A bust will cause a regen effect on you to be reduced by 4, it will not drain HP from you if no regen effect is active.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
