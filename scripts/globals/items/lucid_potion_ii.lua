-----------------------------------
-- ID: 5825
-- Item: Lucid Potion II
-- Item Effect: Restores 1000 HP
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

item_object.onItemUse = function(target)
    target:messageBasic(xi.msg.basic.RECOVERS_HP, 0, target:addHP(1000*xi.settings.ITEM_POWER))
end

return item_object
