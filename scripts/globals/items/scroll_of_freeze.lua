-----------------------------------
-- ID: 4814
-- Scroll of Freeze
-- Teaches the black magic Freeze
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(206)
end

item_object.onItemUse = function(target)
    target:addSpell(206)
end

return item_object
