-----------------------------------
-- ID: 6703
-- Item: Lungo-Nango's Thesis
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    -- Only usable on a mastered job.
    if not target:hasKeyItem(xi.ki.MASTER_BREAKER) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if target:getMod(xi.mod.SUPERIOR_LEVEL) ~= 5 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    -- Item disabled until Examplar Points support is added
    return xi.msg.basic.ITEM_UNABLE_TO_USE
end

itemObject.onItemUse = function(target)
    -- TODO: Grant 4000~6000 examplar points to current job
end

return itemObject
