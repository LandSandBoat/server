-----------------------------------
-- ID: 15763
-- Item: emperor band
-- Experience point bonus
-----------------------------------
-- Bonus: +50%
-- Duration: 720 min
-- Max bonus: 30000 exp
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/item_utils")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.DEDICATION) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end
    return result
end

item_object.onItemUse = function(target)
<<<<<<< Updated upstream
    local effect    = xi.effect.DEDICATION
    local power     = 50
    local duration  = 43200
    local subpower  = 30000

    xi.item_utils.addItemExpEffect(target, effect, power, duration, subpower)
=======
<<<<<<< Updated upstream
    target:addStatusEffect(xi.effect.DEDICATION, 50, 0, 43200, 0, 30000)
=======
    local effect    = xi.effect.DEDICATION
    local power     = 50
    local duration  = 43200
    local subpower  = 3000

    xi.item_utils.addItemExpEffect(target, effect, power, duration, subpower)
>>>>>>> Stashed changes
>>>>>>> Stashed changes
end

return item_object
