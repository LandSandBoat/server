-----------------------------------
-- ID: 28736
-- Maze Voucher 01
-- A slip of paper containing maze construction specifications.
-- To order a maze, it must be attached to a Maze Tabula.
-- It reads, "Sanitization Team Alpha."
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.mmm.onVoucherCheck(target, item)
end

itemObject.onItemUse = function(target, user, item, action)
    return xi.mmm.onVoucherUse(target, item, action)
end

return itemObject
