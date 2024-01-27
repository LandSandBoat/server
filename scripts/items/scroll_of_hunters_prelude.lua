-----------------------------------
-- ID: 5009
-- Scroll of Hunters Prelude
-- Teaches the song Hunters Prelude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HUNTERS_PRELUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HUNTERS_PRELUDE)
end

return itemObject
