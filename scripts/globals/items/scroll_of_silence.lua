-----------------------------------
-- ID: 4667
-- Scroll of Silence
-- Teaches the white magic Silence
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SILENCE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SILENCE)
end

return itemObject
