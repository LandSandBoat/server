-----------------------------------
-- ID: 4881
-- Scroll of Sleepga
-- Teaches the black magic Sleepga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SLEEPGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLEEPGA)
end

return itemObject
