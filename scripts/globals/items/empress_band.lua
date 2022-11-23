-----------------------------------
-- ID: 15762
-- Item: empress band
-- Experience point bonus
-----------------------------------
-- Bonus: +50%
-- Duration: 720 min
-- Max bonus: 15000 exp
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/item_utils")
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
    local subpower  = 15000

    xi.item_utils.addItemExpEffect(target, effect, power, duration, subpower)
end

return itemObject
