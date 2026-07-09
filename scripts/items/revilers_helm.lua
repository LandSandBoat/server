-----------------------------------
-- ID: 15175
-- Item: Reviler's Helm
-- Enchantment: Provoke
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    if not target:isMob() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    -- Grants the same enmity as Provoke (CE 1, VE 1800)
    target:addEnmity(user, 1, 1800)
    target:updateClaim(user)
end

return itemObject
