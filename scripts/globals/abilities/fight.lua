-----------------------------------
-- Ability: Fight
-- Commands your pet to attack the target.
-- Obtained: Beastmaster Level 1
-- Recast Time: 10 seconds
-- Duration: N/A
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif
        target:getID() == player:getPet():getID() or
        (target:getMaster() ~= nil and target:getMaster():isPC())
    then
        return xi.msg.basic.CANNOT_ATTACK_TARGET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local pet = player:getPet()

    if player:checkDistance(pet) <= 25 then
        if pet:hasStatusEffect(xi.effect.HEALING) then
            pet:delStatusEffect(xi.effect.HEALING)
        end

        player:petAttack(target)
    end
end

return abilityObject
