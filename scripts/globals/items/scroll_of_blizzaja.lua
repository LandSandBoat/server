
-----------------------------------
-- ID: 4891
-- Scroll of blizzaja
-- Teaches the black magic blizzaja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZAJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZAJA)
end

return itemObject
