-----------------------------------
-- ID: 4659
-- Scroll of Shell IV
-- Teaches the white magic Shell IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(51)
end

item_object.onItemUse = function(target)
    target:addSpell(51)
end

return item_object
