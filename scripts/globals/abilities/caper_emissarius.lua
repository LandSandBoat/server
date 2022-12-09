-----------------------------------
-- Ability: Caper Emissarius
-- Description: Transfers enmity to a party member of your choice.
-- Obtained: SCH Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-- target:transferEnmity(player, 99, 20.6)
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if target == nil or target:getID() == player:getID() or not target:isPC() then
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    end

    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:transferEnmity(player, 99, 20.6)
end

return abilityObject
