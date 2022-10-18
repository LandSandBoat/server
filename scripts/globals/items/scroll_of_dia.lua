-----------------------------------
-- ID: 4606
-- Scroll of Dia
-- Teaches the white magic Dia
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(23)
end

itemObject.onItemUse = function(target)
    target:addSpell(23)
end

return itemObject
