-----------------------------------
-- ID: 4743
-- Scroll of Reraise
-- Teaches the white magic Reraise
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RERAISE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RERAISE)
end

return itemObject
