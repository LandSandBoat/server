-----------------------------------
-- ID: 4845
-- Scroll of Choke
-- Teaches the black magic Choke
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CHOKE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CHOKE)
end

return itemObject
