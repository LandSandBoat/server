-----------------------------------
-- ID: 6060
-- Item: Animus Minuo Schema
-- Teaches the white magic Animus Minuo
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(309)
end

item_object.onItemUse = function(target)
    target:addSpell(309)
end

return item_object
