-----------------------------------
-- ID: 4676
-- Scroll of Baraera
-- Teaches the white magic Baraera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(68)
end

itemObject.onItemUse = function(target)
    target:addSpell(68)
end

return itemObject
