-----------------------------------
-- ID: 4787
-- Scroll of Blizzaga
-- Teaches the black magic Blizzaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BLIZZAGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZAGA)
end

return itemObject
