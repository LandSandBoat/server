-----------------------------------
-- ID: 18348, 18349, 18650, 18664, 18678, 19759, 19852, 21210, 21211, 22115
-- Item: Yoichinoyumi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.YOICHIS_ARROW, 99 } })
end

return itemObject
