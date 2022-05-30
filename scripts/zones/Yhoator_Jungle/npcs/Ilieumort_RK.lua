-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Ilieumort, R.K.
-- Outpost Conquest Guards
-- !pos 200.254 -1 -80.324 124
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/garrison")
require("scripts/settings/main")
-----------------------------------
local entity = {}

local guardNation = xi.nation.SANDORIA
local guardType   = xi.conq.guard.OUTPOST
local guardRegion = xi.region.ELSHIMOUPLANDS
local guardEvent  = 32763

entity.onTrade = function(player, npc, trade)
    xi.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
    if
        player:getNation() == guardNation or
        xi.settings.GARRISON_NATION_BYPASS == 1
    then
        xi.garrison.onTrade(player, npc, trade)
    else
        --not of nation event
    end
end

entity.onTrigger = function(player, npc)
    local zoneId = npc:getZoneID()
    local win = player:getZone():getLocalVar(string.format("[GARRISON]Treasure_%s", zoneId))
    local won = player:getCharVar("Garrison_Won")
    local lost = player:getCharVar("Garrison_Lose")
    if win >= os.time() then
        -- Trader Won text
        xi.garrison.onWin(player, npc)
    elseif won == 1 then
        -- Party Member Won text
        xi.garrison.onRemove(player)
    elseif lost == 1 then
        -- Party Member Lost text
        xi.garrison.onRemove(player)
    elseif
        win < os.time() and
        win > 0
    then
        -- Trader took too long to claim prize lose
        xi.garrison.onLose(player, npc)
    else
        xi.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
    end
end

entity.onEventUpdate = function(player, csid, option)
    xi.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option)
    xi.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
