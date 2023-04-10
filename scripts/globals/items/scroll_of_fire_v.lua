-----------------------------------
-- ID: 4756
-- Scroll of Fire V
-- Teaches the Black magic Fire V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(148)
end

itemObject.onItemUse = function(target)
    target:addSpell(148)
end

return itemObject
