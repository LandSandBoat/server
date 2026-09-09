-----------------------------------
-- ID: 4248
-- Item: Copy of "Ginuva's Battle Theory"
-- Grants 75 - 200 EXP
-- Source: https://wiki.ffo.jp/html/8068.html
-- Does not grant Limit Points.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local check = 56
    if target:getMainLvl() >= 65 then
        check = 0
    end

    return check
end

itemObject.onItemUse = function(target, user, item, action)
    local exp = xi.settings.main.EXP_RATE * math.randomInt(75, 200)

    target:addExp(exp, false)
    action:messageID(target:getID(), xi.msg.basic.ITEM_EXP_GAINED)

    -- Show the full EXP amount even when EXP is capped.
    return exp
end

return itemObject
