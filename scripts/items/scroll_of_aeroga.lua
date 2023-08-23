-----------------------------------
-- ID: 4792
-- Scroll of Aeroga
-- Teaches the black magic Aeroga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AEROGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AEROGA)
end

return itemObject
