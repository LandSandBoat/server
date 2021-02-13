-----------------------------------
-- Ability: Heel
-- Commands the pet to cease attacking and return to you.
-- Obtained: Beastmaster Level 10
-- Recast Time: 5 seconds
-- Duration: N/A
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getPet() == nil) then
      return tpz.msg.basic.REQUIRES_A_PET, 0
    end

    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local pet = player:getPet()

    if (pet:hasStatusEffect(tpz.effect.HEALING)) then
        pet:delStatusEffect(tpz.effect.HEALING)
    end

    player:petRetreat()
end

return ability_object
