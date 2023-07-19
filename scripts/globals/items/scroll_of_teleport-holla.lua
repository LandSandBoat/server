-----------------------------------
-- ID: 4730
-- Scroll of Teleport-Holla
-- Teaches the white magic Teleport-Holla
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TELEPORT_HOLLA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TELEPORT_HOLLA)
end

return itemObject
