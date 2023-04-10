-----------------------------------
-- ID: 4797
-- Scroll of Stonega
-- Teaches the black magic Stonega
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(189)
end

itemObject.onItemUse = function(target)
    target:addSpell(189)
end

return itemObject
