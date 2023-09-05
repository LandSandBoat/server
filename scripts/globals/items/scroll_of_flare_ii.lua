-----------------------------------
-- ID: 4813
-- Scroll of Flare II
-- Teaches the black magic Flare II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FLARE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLARE_II)
end

return itemObject
