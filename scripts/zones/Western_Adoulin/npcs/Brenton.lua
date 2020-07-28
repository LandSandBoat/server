-----------------------------------
-- Area: Western Adoulin (256)
--  NPC: Brenton
-- Type: SOA Mission NPC
-- !pos 127 -86.036 3.349
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local pioneerRegistration = player:getCurrentMission(SOA) == tpz.mission.id.soa.PIONEER_REGISTRATION
    local lifeOnTheFrontier = player:getCurrentMission(SOA) == tpz.mission.id.soa.LIFE_ON_THE_FRONTIER

    if pioneerRegistration then
        player:startEvent(3)
    elseif lifeOnTheFrontier and player:getFameLevel(ADOULIN) >= 2 then
        player:startEvent(4)
    else
        player:startEvent(576)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3 then
        player:addCurrency('bayld', 1000 * BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, 1000 * BAYLD_RATE)

        player:addKeyItem(tpz.ki.PIONEERS_BADGE) -- Notification for this is shown in the CS, so hand over quietly
        npcUtil.giveKeyItem(player, tpz.ki.MAP_OF_ADOULIN)

        player:completeMission(SOA, tpz.mission.id.soa.PIONEER_REGISTRATION)
        player:addMission(SOA, tpz.mission.id.soa.LIFE_ON_THE_FRONTIER)
    elseif csid == 4 then
        npcUtil.giveKeyItem(player, tpz.ki.DINNER_INVITATION)

        player:completeMission(SOA, tpz.mission.id.soa.LIFE_ON_THE_FRONTIER)
        player:addMission(SOA, tpz.mission.id.soa.MEETING_OF_THE_MINDS)
    end
end
