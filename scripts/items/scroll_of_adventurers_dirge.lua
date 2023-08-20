-----------------------------------
-- ID: 5077
-- Scroll of Adventurer's Dirge
-- Teaches the song Adventurer's Dirge
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ADVENTURERS_DIRGE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ADVENTURERS_DIRGE)
end

return itemObject
