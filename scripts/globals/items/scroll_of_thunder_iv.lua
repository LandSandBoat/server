-----------------------------------
-- ID: 4775
-- Scroll of Thunder IV
-- Teaches the black magic Thunder IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(167)
end

itemObject.onItemUse = function(target)
    target:addSpell(167)
end

return itemObject
