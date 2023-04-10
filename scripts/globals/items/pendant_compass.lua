-----------------------------------
-- ID: 16285
-- Pendant compass
--  Use to determine your precise location in Vana'diel.
--  Provides exact X, Y and Z location, where Y is the altitude.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:showPosition()
end

return itemObject
