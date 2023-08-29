-----------------------------------
-- ID: 4174
-- Item: Vile Elixir
-- Item Effect: Instantly restores 25% of HP and MP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    local mHP = target:getMaxHP()
    local cHP = target:getHP()
    local mMP = target:getMaxMP()
    local cMP = target:getMP()

    if mHP == cHP and mMP == cMP then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE -- Does not let player use item if their hp and mp are full
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addHP((target:getMaxHP() / 100) * 25)
    target:addMP((target:getMaxMP() / 100) * 25)
    target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
end

return itemObject
