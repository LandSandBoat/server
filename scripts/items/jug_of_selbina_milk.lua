-----------------------------------
-- ID: 4378
-- Item: Jug of Selbina Milk
-- Item Effect: regen: 1 HP/tick x 120sec, x 150sec w/ dream robe +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local duration = target:getEquipID(xi.slot.BODY) == xi.item.DREAM_ROBE_P1 and 150 or 120

    if not target:addStatusEffect(xi.effect.REGEN, { power = 1, duration = duration, origin = user, tick = 3 }) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
