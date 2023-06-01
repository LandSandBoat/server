-----------------------------------
-- ID: 5260
-- Item: Regain Feather
-- Status Effect: Medicated, 2 hours
-- Instantly restors HP/MP full TP
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:setHP(target:getMaxHP())
    target:setMP(target:getMaxMP())
    target:setTP(3000)
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 7200)
end

return itemObject
