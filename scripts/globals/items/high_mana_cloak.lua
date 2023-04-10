-----------------------------------
-- ID: 14492
-- Item: High Mana Cloak
-- Item Effect: Restores 50-75 MP
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getMP() == target:getMaxMP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    local mpHeal = math.random(50, 75)
    local dif = target:getMaxMP() - target:getMP()
    if mpHeal > dif then
        mpHeal = dif
    end

    target:addMP(mpHeal)
    target:messageBasic(xi.msg.basic.RECOVERS_MP, 0, mpHeal)
end

return itemObject
