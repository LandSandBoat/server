-----------------------------------
-- Ability: Seigan
-- Grants a bonus to Third Eye when using two-handed weapons.
-- Obtained: Samurai Level 35
-- Recast Time: 1:00
-- Duration: 5:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if not target:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    if target:isWeaponTwoHanded() then
        target:delStatusEffect(xi.effect.HASSO)
        target:delStatusEffect(xi.effect.SEIGAN)
        target:addStatusEffect(xi.effect.SEIGAN, 0, 0, 300)
    end
end

return abilityObject
