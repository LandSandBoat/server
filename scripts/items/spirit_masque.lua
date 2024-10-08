-----------------------------------
-- ID: 4253
-- Spirit Masque
-- A skeletal mask appears on the character's face
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
