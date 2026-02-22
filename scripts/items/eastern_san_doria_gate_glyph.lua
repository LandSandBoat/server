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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.EAST_SANDY_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
