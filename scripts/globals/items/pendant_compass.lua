-----------------------------------
-- ID: 16285
-- Pendant compass
--  Use to determine your precise location in Vana'diel.
--  Provides exact X, Y and Z location, where Y is the altitude.
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:showPosition()
end

return item_object
