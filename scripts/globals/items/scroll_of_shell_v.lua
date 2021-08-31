-----------------------------------
-- ID: 4660
-- Scroll of Shell V
-- Teaches the white magic Shell V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(52)
end

item_object.onItemUse = function(target)
    target:addSpell(52)
end

return item_object
