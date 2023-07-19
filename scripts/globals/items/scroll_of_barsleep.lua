-----------------------------------
-- ID: 4680
-- Scroll of Barsleep
-- Teaches the white magic Barsleep
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARSLEEP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSLEEP)
end

return itemObject
