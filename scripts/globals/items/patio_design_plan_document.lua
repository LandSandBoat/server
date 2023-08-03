-----------------------------------------
-- ID: 6499
-- Item: Patio design plan document
-- Grants keyitem: MOG_PATIO_DESIGN_DOCUMENT
-----------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    -- TODO: Should there be a failure message here?
    return target:hasKeyItem(xi.ki.MOG_PATIO_DESIGN_DOCUMENT) and 1 or 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveKeyItem(target, xi.ki.MOG_PATIO_DESIGN_DOCUMENT)
end

return itemObject
