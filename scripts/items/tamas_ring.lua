-----------------------------------
-- ID: 15545
-- Tamas Ring
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
end

itemObject.onItemUse = function(target)
end

itemObject.onItemDrop = function(target, item, recycleBin)
    if not recycleBin then
        xi.mission.setVar(target, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Timer', 1, GetSystemTime() + 27 * 24 * 60 * 60)
    end
end

return itemObject
