-----------------------------------
-- ID: 15170
-- Item: regen cuirass
-- Item Effect: gives regen
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.REGEN_CUIRASS) then
        if target:hasStatusEffect(xi.effect.REGEN) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REGEN, { power = 15, duration = 180, origin = user, tick = 3, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.REGEN_CUIRASS })
        end
    end
end

return itemObject
