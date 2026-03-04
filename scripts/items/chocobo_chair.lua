-----------------------------------
-- ID: 6411
-- Item: Chocobo Chair
-- Item Effect: Grant Chocobo chair key item
-----------------------------------
---@type TItem
local itemObject = {}

local keyItemId = xi.ki.CHOCOBO_CHAIR

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasKeyItem(keyItemId) then
        return xi.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(xi.msg.basic.OBTAINED_KEY_ITEM, xi.item.CHOCOBO_CHAIR, keyItemId)
end

return itemObject
