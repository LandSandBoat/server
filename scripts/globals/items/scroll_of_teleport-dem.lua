-----------------------------------
-- ID: 4731
-- Scroll of Teleport-Dem
-- Teaches the white magic Teleport-Dem
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TELEPORT_DEM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TELEPORT_DEM)
end

return itemObject
