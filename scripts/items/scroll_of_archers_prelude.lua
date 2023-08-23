-----------------------------------
-- ID: 5010
-- Scroll of Archers Prelude
-- Teaches the song Archers Prelude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ARCHERS_PRELUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ARCHERS_PRELUDE)
end

return itemObject
