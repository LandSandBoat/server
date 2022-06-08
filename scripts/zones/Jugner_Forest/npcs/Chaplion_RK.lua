-----------------------------------
-- Area: Jugner Forest
--  NPC: Chaplion, R.K.
-- Outpost Conquest Guards
-- !pos 54 0 -11 104
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/garrison")
require("scripts/settings/main")
-----------------------------------
local entity = {}

local guardNation = xi.nation.SANDORIA
local guardType   = xi.conq.guard.OUTPOST
local guardRegion = xi.region.NORVALLEN
local guardEvent  = 32763

entity.onTrade = function(player, npc, trade)
    local zoneId = player:getZoneID()
    local text = zones[zoneId].text
    xi.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
    if
        player:getNation() == guardNation or
        xi.settings.GARRISON_NATION_BYPASS == 1
    then
        xi.garrison.onTrade(player, npc, trade)
    else
        --not of nation event
        player:messageSpecial(text.GARRISON_BASE, trade:getItem():getID(), player:getNation())
    end
end

entity.onTrigger = function(player, npc)
    local zoneId = npc:getZoneID()
    local text = zones[zoneId].text
    local win = player:getZone():getLocalVar(string.format("[GARRISON]Treasure_%s", zoneId))
    local won = player:getCharVar("Garrison_Won")
    local lost = player:getCharVar("Garrison_Lose")
    if win >= os.time() then
        -- Trader Won
        player:messageSpecial(text.GARRISON_BASE + 36)
        xi.garrison.onWin(player, npc)
    elseif won == 1 then
        -- Party Member Won
        player:messageSpecial(text.GARRISON_BASE + 39)
        xi.garrison.onRemove(player)
    elseif lost == 1 then
        -- Party Member Lost
        player:messageSpecial(text.GARRISON_BASE + 37)
        xi.garrison.onRemove(player)
    elseif
        win < os.time() and
        win > 0
    then
        -- Trader took too long to claim prize lose
        player:messageSpecial(text.GARRISON_BASE + 37)
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
