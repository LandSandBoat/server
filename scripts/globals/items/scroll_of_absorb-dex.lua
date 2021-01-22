-----------------------------------
-- ID: 4875
-- Scroll of Absorb-DEX
-- Teaches the black magic Absorb-DEX
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(267)
end

item_object.onItemUse = function(target)
    target:addSpell(267)
end

return item_object
