-----------------------------------
-- ID: 4939
-- Scroll of Doton: San
-- Teaches the ninjutsu Doton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(331)
end

itemObject.onItemUse = function(target)
    target:addSpell(331)
end

return itemObject
