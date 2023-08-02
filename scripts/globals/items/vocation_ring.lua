-----------------------------------
-- ID: 28563
-- Item: vocation ring
-- Capacity point bonus
-----------------------------------
-- Bonus: +100%
-- Duration: 720 min
-- Max bonus: 12000 exp
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/item_utils")
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
    local power     = 100
    local duration  = 43200
    local subpower  = 12000

    xi.item_utils.addItemExpEffect(target, effect, power, duration, subpower)
end

return itemObject
