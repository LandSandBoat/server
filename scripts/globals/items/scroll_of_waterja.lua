-----------------------------------
-- ID: 4895
-- Scroll of Waterja
-- Teaches the Black magic Waterja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATERJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERJA)
end

return itemObject
