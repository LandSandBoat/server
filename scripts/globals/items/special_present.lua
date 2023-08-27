-----------------------------------
-- ID: 5269
-- Item: Special Present
-- Starlight Celebration Fame Reward
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    local dreamHatHQ = target:hasItem(xi.items.DREAM_HAT_P1)

    if not dreamHatHQ then
        npcUtil.giveItem(target, xi.items.DREAM_HAT_P1)
    else
        npcUtil.giveItem(target, xi.items.CANDY_CANE)
    end

    return 0
end

itemObject.onItemDrop = function(target)
    local dreamHatHQ = target:hasItem(xi.items.DREAM_HAT_P1)

    if not dreamHatHQ then
        target:setCharVar("[StarlightMisc]DreamHatHQ", 0)
    end
end

return itemObject
