-----------------------------------
-- ID: 14656
-- Item: Poseidon's Ring
-- Effect: Summon Water Spirit Pet
-----------------------------------
require("scripts/globals/pets")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    local result = 0
    if target:hasPet() then
        result = xi.msg.basic.ALREADY_HAS_A_PET
    elseif not target:canUseMisc(xi.zoneMisc.PET) then
        result = xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return result
end

itemObject.onItemUse = function(target)
    xi.pet.spawnPet(target, xi.pet.id.WATER_SPIRIT)
end

return itemObject
