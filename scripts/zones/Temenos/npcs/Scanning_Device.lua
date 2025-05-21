-----------------------------------
-- Area: Temenos
--  NPC: Scanning_Device
-- !pos 586 0 66 37
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.METAL_CHIP) then
        player:startEvent(121, 257)
    elseif npcUtil.tradeHas(trade, { 1986, 1908, 1907 }) then
        player:startEvent(121, 17)
    elseif npcUtil.tradeHas(trade, xi.item.IVORY_CHIP) then
        player:startEvent(121, 33)
    elseif npcUtil.tradeHas(trade, xi.item.SCARLET_CHIP) then
        player:startEvent(121, 65)
    elseif npcUtil.tradeHas(trade, xi.item.EMERALD_CHIP) then
        player:startEvent(121, 129)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(121, 15)
end

local timeVarNames =
{
    [1] = '[TEMENOS_NORTHERN_TOWER]Time',
    [2] = '[TEMENOS_EASTERN_TOWER]Time',
    [3] = '[TEMENOS_WESTERN_TOWER]Time',
    [4] = '[CENTRAL_TEMENOS_4TH_FLOOR]Time',
    [5] = '[CENTRAL_TEMENOS_3RD_FLOOR]Time',
    [6] = '[CENTRAL_TEMENOS_2ND_FLOOR]Time',
    [7] = '[CENTRAL_TEMENOS_1ST_FLOOR]Time',
    [8] = '[CENTRAL_TEMENOS_BASEMENT]Time',
}

entity.onEventUpdate = function(player, csid, option, npc)
    player:updateEvent(0, GetServerVariable(timeVarNames[option]), 0, 0, 0, 0, 0, 0)
end

return entity
