-----------------------------------
-- ID: 4729
-- Scroll of Teleport-Altep
-- Teaches the white magic Teleport-Altep
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TELEPORT_ALTEP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TELEPORT_ALTEP)
end

return itemObject
