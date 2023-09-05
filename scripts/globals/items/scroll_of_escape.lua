-----------------------------------
-- ID: 4871
-- Scroll of Escape
-- Teaches the black magic Escape
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ESCAPE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ESCAPE)
end

return itemObject
