-----------------------------------
-- ID: 4625
-- Scroll of Silena
-- Teaches the white magic Silena
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SILENA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SILENA)
end

return itemObject
