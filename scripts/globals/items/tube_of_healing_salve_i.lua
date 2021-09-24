-----------------------------------
-- ID: 5835
-- Item: tube_of_healing_salve_i
-- Item Effect: Instantly restores 50% of pet HP
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if not target:hasPet() then
        return xi.msg.basic.REQUIRES_A_PET
    end
    return 0
end

item_object.onItemUse = function(target)
    local pet = target:getPet()
    local totalHP = pet:getMaxHP() / 2
    pet:addHP(totalHP)
    pet:messageBasic(xi.msg.basic.RECOVERS_HP, 0, totalHP)
end

return item_object
