-----------------------------------
-- ID: 5070
-- Scroll of Magic Finale
-- Teaches the song Magic Finale
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.MAGIC_FINALE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MAGIC_FINALE)
end

return itemObject
