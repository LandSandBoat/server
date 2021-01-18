-----------------------------------
-- ID: 4246
-- Item: Cantarella
-- Item Effect: Poison 10HP / Removes 2000 HP over 10 minutes
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if not target:hasStatusEffect(tpz.effect.POISON) then
        target:addStatusEffect(tpz.effect.POISON, 10, 3, 600)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
