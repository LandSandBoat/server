-----------------------------------
--  ID: 16224
--  Apple au lait Tank
--  When used, you will obtain one Apple au lait
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.FLASK_OF_APPLE_AU_LAIT, 1 } })
end

return itemObject
