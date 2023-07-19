-----------------------------------
-- ID: 6571
-- Scroll of Phalanx II
-- Teaches the white magic Phalanx II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PHALANX_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PHALANX_II)
end

return itemObject
