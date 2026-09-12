-----------------------------------
-- ID: 4198
-- Item: Page from the Dragon Chronicles
-- Grants 500 - 1,000 EXP
-- Source: https://wiki.ffo.jp/html/2144.html
-- Does not grant Limit Points.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local check = 56
    if target:getMainLvl() >= 4 then
        check = 0
    end

    return check
end

itemObject.onItemUse = function(target, user, item, action)
    local exp = xi.settings.main.EXP_RATE * math.randomInt(500, 1000)

    target:addExp(exp, false)
    action:messageID(target:getID(), xi.msg.basic.ITEM_EXP_GAINED)

    -- Show the full EXP amount even when EXP is capped.
    return exp
end

return itemObject
