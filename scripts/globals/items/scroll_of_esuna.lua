-----------------------------------
-- ID: 4703
-- Scroll of Esuna
-- Teaches the white magic Esuna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(95)
end

itemObject.onItemUse = function(target)
    target:addSpell(95)
end

return itemObject
