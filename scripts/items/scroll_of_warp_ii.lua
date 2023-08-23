-----------------------------------
-- ID: 4870
-- Scroll of Warp II
-- Teaches the black magic Warp II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WARP_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WARP_II)
end

return itemObject
