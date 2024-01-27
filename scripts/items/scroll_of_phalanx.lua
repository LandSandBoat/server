-----------------------------------
-- ID: 4714
-- Scroll of Phalanx
-- Teaches the white magic Phalanx
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PHALANX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PHALANX)
end

return itemObject
