-----------------------------------
-- ID: 4247
-- Item: Page From Miratete's Memoirs
-- Grants 750 - 1,500 EXP
-- Source: https://wiki.ffo.jp/html/2132.html
-- Does not grant Limit Points.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local check = 56
    if target:getMainLvl() >= 20 then
        check = 0
    end

    return check
end

itemObject.onItemUse = function(target, user, item, action)
    local exp = xi.settings.main.EXP_RATE * math.randomInt(750, 1500)

    target:addExp(exp, false)
    action:messageID(target:getID(), xi.msg.basic.ITEM_EXP_GAINED)

    -- Show the full EXP amount even when EXP is capped.
    return exp
end

return itemObject
