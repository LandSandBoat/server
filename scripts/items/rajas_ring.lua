-----------------------------------
-- ID: 15543
-- Rajas Ring
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
end

itemObject.onItemUse = function(target)
end

itemObject.onItemDrop = function(target, item)
    xi.mission.setVar(target, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Timer', 1, os.time() + 27 * 24 * 60 * 60)
end

return itemObject
