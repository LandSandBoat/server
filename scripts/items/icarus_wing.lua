-----------------------------------
-- ID: 4213
-- Icarus Wing
-- Increases TP of the user by 1000
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:addTP(1000)
    target:addStatusEffect(xi.effect.MEDICINE, { duration = 7200, origin = user })
end

return itemObject
