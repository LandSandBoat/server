-----------------------------------
-- ID: 4772
-- Scroll of Thunder
-- Teaches the black magic Thunder
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDER)
end

return itemObject
