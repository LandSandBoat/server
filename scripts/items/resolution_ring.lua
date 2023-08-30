-----------------------------------
-- ID: 28568
-- Item: Resolution Ring
-- Experience point bonus
-----------------------------------
-- Bonus: +50%
-- Duration: 720 min
-- Max bonus: 30000 exp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.DEDICATION) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.DEDICATION
    local power     = 50
    local duration  = 43200
    local subpower  = 30000

    xi.itemUtils.addItemExpEffect(target, effect, power, duration, subpower)
end

return itemObject
