-----------------------------------
-- ID: 15452
-- Item: Fisherman's belt
-- Enchantment: Fishing image support
-- Duration: 120Min
-- Fishing Skill +2
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.FISHING_IMAGERY) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.FISHING_IMAGERY, { power = 2, duration = 120 * 60, origin = user })
end

return itemObject
