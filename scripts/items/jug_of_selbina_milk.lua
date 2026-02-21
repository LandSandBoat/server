-----------------------------------
-- ID: 4378
-- Item: Jug of Selbina Milk
-- Item Effect: regen: 1 HP/tick x 120sec, x 150sec w/ dream robe +1
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        if target:getEquipID(xi.slot.BODY) == 14520 then -- Dream Robe +1
            target:addStatusEffect(xi.effect.REGEN, { power = 1, duration = 150, origin = user, tick = 3 })
        else
            target:addStatusEffect(xi.effect.REGEN, { power = 1, duration = 120, origin = user, tick = 3 })
        end
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
