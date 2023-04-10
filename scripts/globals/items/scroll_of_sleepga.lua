-----------------------------------
-- ID: 4881
-- Scroll of Sleepga
-- Teaches the black magic Sleepga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(273)
end

itemObject.onItemUse = function(target)
    target:delSpell(363)
    target:addSpell(273)
end

return itemObject
