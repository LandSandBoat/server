-----------------------------------
-- ID: 4860
-- Scroll of Stun
-- Teaches the black magic Stun
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(252)
end

itemObject.onItemUse = function(target)
    target:addSpell(252)
end

return itemObject
