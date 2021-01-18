-----------------------------------
-- ID: 4628
-- Scroll of Cursna
-- Teaches the white magic Cursna
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(20)
end

item_object.onItemUse = function(target)
    target:addSpell(20)
end

return item_object
