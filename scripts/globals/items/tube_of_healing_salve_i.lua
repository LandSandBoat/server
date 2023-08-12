-----------------------------------
-- ID: 5835
-- Item: tube_of_healing_salve_i
-- Item Effect: Instantly restores 50% of pet HP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:hasPet() then
        return xi.msg.basic.REQUIRES_A_PET
    end

    return 0
end

itemObject.onItemUse = function(target)
    local pet = target:getPet()
    local totalHP = pet:getMaxHP() / 2
    pet:addHP(totalHP)
    pet:messageBasic(xi.msg.basic.RECOVERS_HP, 0, totalHP)
end

return itemObject
