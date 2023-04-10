-----------------------------------
-- ID: 5100
-- Scroll of Boost-CHR
-- Teaches the white magic Boost-CHR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(485)
end

itemObject.onItemUse = function(target)
    target:addSpell(485)
end

return itemObject
