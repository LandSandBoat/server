-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sharin-Garin
-- Type: Adventurer's Assistant
-- !pos 122.658 -1.315 33.001 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local mercRank = tpz.besieged.getMercenaryRank(player)
    local hasPermit = player:hasKeyItem(tpz.ki.RUNIC_PORTAL_USE_PERMIT) and 1 or 0
    local points = player:getCurrency("imperial_standing")
    local hasAstral = tpz.besieged.getAstralCandescence()
    local cost = 200 -- 200 IS to get a permit
    local captain = mercRank == 11 and 1 or 0

    player:startEvent(140, 0, mercRank, hasPermit, points, hasAstral, cost, captain)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 140 and option == 1 and npcUtil.giveKeyItem(player, tpz.ki.RUNIC_PORTAL_USE_PERMIT) then
        player:delCurrency("imperial_standing", 200)
    elseif csid == 140 and option == 2 then
        npcUtil.giveKeyItem(player, tpz.ki.RUNIC_PORTAL_USE_PERMIT)
    end
end
