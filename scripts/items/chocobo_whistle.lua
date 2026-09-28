-----------------------------------
-- ID: 15533
-- Item: Chocobo Whistle
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/whistle')
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    if not target:canUseMisc(xi.zoneMisc.MOUNT) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif
        target:getMainLvl() < 20 or
        not target:hasKeyItem(xi.keyItem.CHOCOBO_LICENSE) or
        target:hasEnmity()
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE -- TODO: Verify/correct message, order of message priority.
    end

    -- TODO: The message for a whistle with no chocobo registered.
    if not target:getFieldChocobo() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    local ride = xi.chocoboRaising.whistle.ride(target)

    target:addStatusEffect(xi.effect.MOUNTED,
    {
        power    = xi.mount.CHOCOBO,
        duration = ride.seconds,
        origin   = user,
        subPower = xi.chocoboRaising.personalChocoboFlag,
        silent   = true,
    })
end

return itemObject
