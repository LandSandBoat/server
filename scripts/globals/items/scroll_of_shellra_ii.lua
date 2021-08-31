-----------------------------------
-- ID: 4739
-- Scroll of Shellra II
-- Teaches the white magic Shellra II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(131)
end

item_object.onItemUse = function(target)
    target:addSpell(131)
end

return item_object
