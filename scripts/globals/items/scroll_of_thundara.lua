-----------------------------------
-- ID: 4924
-- Scroll of Thundara
-- Teaches the black magic Thundara
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(836)
end

item_object.onItemUse = function(target)
    target:addSpell(836)
end

return item_object
