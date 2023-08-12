-----------------------------------
-- ID: 4144
-- Item: Hi-Elixir
-- Item Effect: Instantly restores 50% of HP and MP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    local mHP = target:getMaxHP()
    local cHP = target:getHP()
    local mMP = target:getMaxMP()
    local cMP = target:getMP()

    if mHP == cHP and mMP == cMP then
        result = 56 -- Does not let player use item if their hp and mp are full
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addHP((target:getMaxHP() / 100) * 50)
    target:addMP((target:getMaxMP() / 100) * 50)
    target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
end

return itemObject
