-----------------------------------
-- ID: 4647
-- Scroll of Banishga II
-- Teaches the white magic Banishga II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(39)
end

item_object.onItemUse = function(target)
    target:addSpell(39)
end

return item_object
