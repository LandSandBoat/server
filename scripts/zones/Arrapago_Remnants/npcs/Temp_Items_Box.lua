-----------------------------------
-- Area: Arrapago Remnants
-- NPC: Temp Items Box
-----------------------------------
---@type TNpcEntity
local entity = {}

local floorOneItems =
{
    [1] = { itemID = xi.item.HI_POTION,                minAmount = 3, maxAmount = 6 },
    [2] = { itemID = xi.item.HERMES_QUENCHER,          minAmount = 2, maxAmount = 4 },
    [3] = { itemID = xi.item.DUSTY_ETHER,              minAmount = 3, maxAmount = 6 },
    [4] = { itemID = xi.item.FLASK_OF_STRANGE_MILK,    minAmount = 3, maxAmount = 6 },
}

entity.onTrigger = function(player, npc)
    local instance = player:getInstance()

    if not instance then
        return
    end

    if instance:getStage() == 1 then
        xi.salvage.tempBoxTrigger(player, npc, floorOneItems)
    else
        xi.salvage.tempBoxTrigger(player, npc)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.salvage.tempBoxFinish(player, csid, option, npc)
end

return entity
