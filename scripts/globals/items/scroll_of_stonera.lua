-----------------------------------
-- ID: 4922
-- Scroll of Stonera
-- Teaches the black magic Stonera
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONERA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONERA)
end

return itemObject
