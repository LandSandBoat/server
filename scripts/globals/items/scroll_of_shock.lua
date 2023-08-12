-----------------------------------
-- ID: 4847
-- Scroll of Shock
-- Teaches the black magic Shock
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHOCK)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHOCK)
end

return itemObject
