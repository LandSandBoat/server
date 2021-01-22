-----------------------------------
-- ID: 4725
-- Scroll of Enstone II
-- Teaches the white magic Enstone II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(315)
end

item_object.onItemUse = function(target)
    target:addSpell(315)
end

return item_object
