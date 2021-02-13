-----------------------------------
-- ID: 15312
-- Item: Mist Pumps
-- Item Effect: Evasion Boost
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.EVASION_BOOST)) then
        target:addStatusEffect(tpz.effect.EVASION_BOOST, 15, 0, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
