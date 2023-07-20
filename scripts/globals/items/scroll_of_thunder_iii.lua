-----------------------------------
-- ID: 4774
-- Scroll of Thunder III
-- Teaches the black magic Thunder III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDER_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDER_III)
end

return itemObject
