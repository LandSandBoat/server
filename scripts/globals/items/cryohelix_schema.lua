-----------------------------------
-- ID: 6044
-- Cryohelix Schema
-- Teaches the black magic Cryohelix
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(282)
end

item_object.onItemUse = function(target)
    target:addSpell(282)
end

return item_object
