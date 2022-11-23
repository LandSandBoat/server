-----------------------------------
-- ID: 5411
-- Item: bottle_of_dawn_mulsum
-- Item Effect: Instantly restores 20%-35% of pet HP
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
    local percent = math.random(20, 35) * xi.settings.main.ITEM_POWER
    local pet = target:getPet()
    local totalHP = (pet:getMaxHP() / 100) * percent
    pet:addHP(totalHP)
    pet:messageBasic(xi.msg.basic.RECOVERS_HP, 0, totalHP)
end

return itemObject
