-----------------------------------
-- ID: 4860
-- Scroll of Stun
-- Teaches the black magic Stun
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STUN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STUN)
end

return itemObject
