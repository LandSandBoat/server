-----------------------------------
-- ID: 4709
-- Scroll of Enblizzard
-- Teaches the white magic Enblizzard
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ENBLIZZARD)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENBLIZZARD)
end

return itemObject
