-----------------------------------
-- ID: Unknown
-- Scroll of Addle
-- Teaches the magic Addle
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ADDLE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ADDLE)
end

return itemObject
