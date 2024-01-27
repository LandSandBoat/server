-----------------------------------
-- ID: 4820
-- Scroll of Burst
-- Teaches the black magic Burst
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BURST)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BURST)
end

return itemObject
