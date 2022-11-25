-----------------------------------------
-- ID: 15817
-- Item: Ecphoria Ring
-- Item Effect: This item remedies amnesia.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.AMNESIA) then
        target:delStatusEffect(xi.effect.AMNESIA)
    end
end

return itemObject
