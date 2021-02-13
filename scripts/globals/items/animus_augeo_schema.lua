-----------------------------------
-- ID: 6059
-- Item: Animus Augeo Schema
-- Teaches the white magic Animus Augeo
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(308)
end

item_object.onItemUse = function(target)
    target:addSpell(308)
end

return item_object
