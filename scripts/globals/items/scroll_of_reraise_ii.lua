-----------------------------------
-- ID: 4749
-- Scroll of Reraise II
-- Teaches the white magic Reraise II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(141)
end

itemObject.onItemUse = function(target)
    target:addSpell(141)
end

return itemObject
