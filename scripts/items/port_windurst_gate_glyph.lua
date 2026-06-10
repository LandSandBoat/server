-----------------------------------
-- ID: 4194
-- Port Windurst Gate Glyph
-- Transports the user to the Port Windurst gate
-- (near Milma-Hapilma, W.W.)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.PORT_WINDY_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
