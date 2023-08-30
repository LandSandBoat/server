-----------------------------------
-- ID: 27557
-- Item: trizek ring
-- Capacity point bonus
-----------------------------------
-- Bonus: +150%
-- Duration: 720 min
-- Max bonus: 30000 exp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.COMMITMENT) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.COMMITMENT
    local power     = 150
    local duration  = 43200
    local subpower  = 30000

    xi.itemUtils.addItemExpEffect(target, effect, power, duration, subpower)
end

return itemObject
