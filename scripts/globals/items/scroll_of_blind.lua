-----------------------------------
-- ID: 4862
-- Scroll of Blind
-- Teaches the black magic Blind
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(254)
end

itemObject.onItemUse = function(target)
    target:addSpell(254)
end

return itemObject
