-----------------------------------
-- ID: 4190
-- Eastern San d'Oria Gate Glyph
-- Transports the user to the eastern Southern San d'oria gate
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.EAST_SANDY_GLYPH, 0, 3)
end

return itemObject
