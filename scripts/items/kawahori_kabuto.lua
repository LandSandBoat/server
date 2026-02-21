-----------------------------------
-- ID: 16071
-- Item: kawahori_kabuto
-- Effect: blindness
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.BLINDNESS) then
        target:addStatusEffect(xi.effect.BLINDNESS, { power = 25, duration = 180, origin = user })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
