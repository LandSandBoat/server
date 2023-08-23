-----------------------------------
-- ID: 4861
-- Scroll of Sleep
-- Teaches the black magic Sleep
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SLEEP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLEEP)
end

return itemObject
