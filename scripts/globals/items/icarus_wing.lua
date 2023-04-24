-----------------------------------
-- ID: 4213
-- Icarus Wing
-- Increases TP of the user by 1000
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
    target:addTP(1000)
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 7200)
end

return itemObject
