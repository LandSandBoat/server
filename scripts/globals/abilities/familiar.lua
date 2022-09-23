-----------------------------------
-- Ability: Familiar
-- Enhances your pet's powers and increases the duration of Charm.
-- Obtained: Beastmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 0:30:00
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not player:isJugPet() and pet:getObjType() ~= xi.objType.MOB then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    elseif pet:getLocalVar("ReceivedFamiliar") == 1 then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        pet:setLocalVar("ReceivedFamiliar", 1)
        ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    player:familiar()

    -- pets powers increase!
    ability:setMsg(xi.msg.basic.FAMILIAR_PC)

    return 0
end

return ability_object
