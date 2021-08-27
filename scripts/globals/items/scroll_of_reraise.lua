-----------------------------------
-- ID: 4743
-- Scroll of Reraise
-- Teaches the white magic Reraise
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(135)
end

item_object.onItemUse = function(target)
    target:addSpell(135)
end

return item_object
