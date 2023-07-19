-----------------------------------
-- ID: 5041
-- Scroll of Vital Etude
-- Teaches the song Vital Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.VITAL_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VITAL_ETUDE)
end

return itemObject
