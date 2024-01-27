-----------------------------------
-- ID: 4812
-- Scroll of Flare
-- Teaches the black magic Flare
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FLARE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLARE)
end

return itemObject
