-----------------------------------
-- ID: 15761
-- Item: chariot band
-- Experience point bonus
-----------------------------------
-- Bonus: +75%
-- Duration: 720 min
-- Max bonus: 10000 exp
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
    local power     = 75
    local duration  = 43200
    local subpower  = 10000

    xi.item_utils.addItemExpEffect(target, effect, power, duration, subpower)
=======
<<<<<<< Updated upstream
    target:addStatusEffect(xi.effect.DEDICATION, 75, 0, 43200, 0, 10000)
=======
    local effect    = xi.effect.DEDICATION
    local power     = 75
    local duration  = 43200
    local subpower  = 1000

    xi.item_utils.addItemExpEffect(target, effect, power, duration, subpower)
>>>>>>> Stashed changes
>>>>>>> Stashed changes
end

return item_object
