-----------------------------------
-- Ability: Familiar
-- Enhances your pet's powers and increases the duration of Charm.
-- Obtained: Beastmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 0:30:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif not player:isJugPet() and pet:getObjType() ~= tpz.objType.MOB then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    elseif pet:getLocalVar("ReceivedFamiliar") == 1 then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    else
        pet:setLocalVar("ReceivedFamiliar", 1)
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    player:familiar()

    -- pets powers increase!
    ability:setMsg(tpz.msg.basic.FAMILIAR_PC)

    return 0
end

return ability_object
