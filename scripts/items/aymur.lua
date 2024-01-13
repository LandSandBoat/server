-----------------------------------
-- Aymur
-- BST mythic
-- Enhances "Sic" and "Ready" effect
-----------------------------------

local itemObject = {}

local addPetListener = function(pet)
    pet:addListener('WEAPONSKILL_BEFORE_USE', 'AYMUR_ABILITY', function()
        if pet:getMaster() then -- ensure we don't keep giving TP after charm wears off
            if pet:getPetID() == 0 then -- charmed pets do not have petID
                -- give remaining 500 tp just before ability
                pet:addTP(500)
            else
                pet:addTP(1000)
            end
        else
            pet:removeListener('AYMUR_ABILITY')
        end
    end)
end

itemObject.onItemEquip = function(target, item)
    if item:getID() == 18979 then
        return
    end

    local playerPet = target:getPet()
    if playerPet then
        addPetListener(playerPet)
    end

    target:addListener('ABILITY_USE', 'AYMUR_CREATE_PET', function(playerArg, targetArg, ability, action)
        local pet = playerArg:getPet()
        if pet then
            if
                ability:getID() == xi.jobAbility.CHARM or
                ability:getID() == xi.jobAbility.CALL_BEAST
            then
                addPetListener(pet)
            end
        end

        if ability:getID() == xi.jobAbility.SIC then
            if pet:getPetID() == 0 then-- charmed pets do not have petID
                -- give 500 tp to use an ability sooner
                pet:addTP(500)
            end
        end
    end)
end

itemObject.onItemUnequip = function(target, item)
    target:removeListener('AYMUR_CREATE_PET')
    local pet = target:getPet()
    if pet then
        pet:removeListener('AYMUR_ABILITY')
    end
end

return itemObject
