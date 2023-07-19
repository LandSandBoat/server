-----------------------------------
-- ID: 4636
-- Scroll of Banish
-- Teaches the white magic Banish
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BANISH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BANISH)
end

return itemObject
