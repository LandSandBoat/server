-----------------------------------
-- ID: 6410
-- Item: Shadow Throne
-- Item Effect: Grant Leaf bench key item
-----------------------------------
---@type TItem
local itemObject = {}

local keyItemId = xi.ki.SHADOW_THRONE

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, xi.item.SHADOW_THRONE, keyItemId)
end

return itemObject
