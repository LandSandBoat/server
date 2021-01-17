-----------------------------------------
-- ID: 6045
-- Geohelix Schema
-- Teaches the black magic Geohelix
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(278)
end

item_object.onItemUse = function(target)
    target:addSpell(278)
end

return item_object
