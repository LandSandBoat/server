-----------------------------------
-- ID: 4660
-- Scroll of Shell V
-- Teaches the white magic Shell V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(52)
end

itemObject.onItemUse = function(target)
    target:addSpell(52)
end

return itemObject
