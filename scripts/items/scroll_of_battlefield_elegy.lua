-----------------------------------
-- ID: 5029
-- Scroll of Battlefield Elegy
-- Teaches the song Battlefield Elegy
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BATTLEFIELD_ELEGY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BATTLEFIELD_ELEGY)
end

return itemObject
