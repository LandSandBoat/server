-----------------------------------
-- ID: 5083
-- Scroll of Cura III
-- Teaches the white magic Cura III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(475)
end

item_object.onItemUse = function(target)
    target:addSpell(475)
end

return item_object
