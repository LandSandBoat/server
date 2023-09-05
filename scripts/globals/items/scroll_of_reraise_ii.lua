-----------------------------------
-- ID: 4749
-- Scroll of Reraise II
-- Teaches the white magic Reraise II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RERAISE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RERAISE_II)
end

return itemObject
