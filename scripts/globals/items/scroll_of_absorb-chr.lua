-----------------------------------
-- ID: 4880
-- Scroll of Absorb-CHR
-- Teaches the black magic Absorb-CHR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(272)
end

itemObject.onItemUse = function(target)
    target:addSpell(272)
end

return itemObject
