-----------------------------------------
-- ID: 4175
-- Item: Vile Elixir +1
-- Item Effect: Instantly restores 55% of HP and MP
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    local mHP = target:getMaxHP()
    local cHP = target:getHP()
    local mMP = target:getMaxMP()
    local cMP = target:getMP()

    if mHP == cHP and mMP == cMP then
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE -- Does not let player use item if their hp and mp are full
    end

    return result
end

item_object.onItemUse = function(target)
    target:addHP((target:getMaxHP()/100)*55)
    target:addMP((target:getMaxMP()/100)*55)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
end

return item_object
