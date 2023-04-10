-----------------------------------
-- ID: 4895
-- Scroll of Waterja
-- Teaches the Black magic Waterja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(501)
end

itemObject.onItemUse = function(target)
    target:addSpell(501)
end

return itemObject
