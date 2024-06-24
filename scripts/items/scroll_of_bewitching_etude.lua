-----------------------------------
-- ID: 5045
-- Scroll of Bewitching Etude
-- Teaches the song Bewitching Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BEWITCHING_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BEWITCHING_ETUDE)
end

return itemObject
