-----------------------------------
-- ID: 5269
-- Item: Special Present
-- Starlight Celebration Fame Reward
-----------------------------------
require("scripts/globals/status")
require('scripts/globals/npc_util')
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
end

itemObject.onItemUse = function(target)
    local dreamHatHQ = target:hasItem(15179)

    if not dreamHatHQ then
        npcUtil.giveItem(target, 15179)
    else
        npcUtil.giveItem(target, 5622)
    end

    return 0
end

return itemObject
