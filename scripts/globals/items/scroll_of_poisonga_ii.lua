-----------------------------------
-- ID: 4834
-- Scroll of Poisonga II
-- Teaches the black magic Poisonga II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(226)
end

item_object.onItemUse = function(target)
    target:addSpell(226)
end

return item_object
