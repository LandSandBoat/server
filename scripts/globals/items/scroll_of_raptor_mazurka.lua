-----------------------------------
-- ID: 5075
-- Scroll of Raptor Mazurka
-- Teaches the song Raptor Mazurka
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RAPTOR_MAZURKA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAPTOR_MAZURKA)
end

return itemObject
