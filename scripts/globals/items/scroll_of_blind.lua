-----------------------------------
-- ID: 4862
-- Scroll of Blind
-- Teaches the black magic Blind
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(254)
end

item_object.onItemUse = function(target)
    target:addSpell(254)
end

return item_object
