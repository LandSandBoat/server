-----------------------------------
-- ID: 5011
-- Scroll of Sheepfoe Mambo
-- Teaches the song Sheepfoe Mambo
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SHEEPFOE_MAMBO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHEEPFOE_MAMBO)
end

return itemObject
