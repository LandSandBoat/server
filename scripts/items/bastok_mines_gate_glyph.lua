-----------------------------------
-- ID: 4187
-- Bastok Mines Gate Glyph
-- Transports the user to the Bastok Mines gate
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BASTOK_MINES_GLYPH, 0, 3)
end

return itemObject
