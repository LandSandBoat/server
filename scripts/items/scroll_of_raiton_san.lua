-----------------------------------
-- ID: 4942
-- Scroll of Raiton: San
-- Teaches the ninjutsu Raiton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RAITON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RAITON_SAN)
end

return itemObject
