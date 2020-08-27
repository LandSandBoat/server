-----------------------------------
-- Ability: Fight
-- Commands your pet to attack the target.
-- Obtained: Beastmaster Level 1
-- Recast Time: 10 seconds
-- Duration: N/A
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    else
        if (target:getID() == player:getPet():getID() or (target:getMaster() ~= nil and target:getMaster():isPC())) then
            return tpz.msg.basic.CANNOT_ATTACK_TARGET, 0
        else
            return 0, 0
        end
    end
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()

    if (player:checkDistance(pet) <= 25) then
        if (pet:hasStatusEffect(tpz.effect.HEALING)) then
            pet:delStatusEffect(tpz.effect.HEALING)
        end

        player:petAttack(target)
    end
end
