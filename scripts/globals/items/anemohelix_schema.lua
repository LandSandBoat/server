-----------------------------------
-- ID: 6046
-- Item: Anemohelix Schema
-- Teaches the black magic Anemohelix
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(280)
end

item_object.onItemUse = function(target)
    target:addSpell(280)
end

return item_object
