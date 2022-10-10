-----------------------------------
-- ID: 4725
-- Scroll of Enstone II
-- Teaches the white magic Enstone II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(315)
end

itemObject.onItemUse = function(target)
    target:addSpell(315)
end

return itemObject
