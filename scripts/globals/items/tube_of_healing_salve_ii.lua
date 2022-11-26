-----------------------------------
-- ID: 5836
-- Item: tube_of_healing_salve_ii
-- Item Effect: Instantly restores 100% of pet HP
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
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
    local totalHP = pet:getMaxHP()
    pet:addHP(totalHP)
    pet:messageBasic(xi.msg.basic.RECOVERS_HP, 0, totalHP)
end

return itemObject
