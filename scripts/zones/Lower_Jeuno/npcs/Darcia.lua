-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Darcia
--  SoA: Mission NPC
-- !pos 25 -38.617 -1.000
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rumorsFromTheWest = player:getCurrentMission(SOA) == xi.mission.id.soa.RUMORS_FROM_THE_WEST
    local theGeomagnetron = player:getCurrentMission(SOA) == xi.mission.id.soa.THE_GEOMAGNETRON

    -- Dialog options bits
    local turnOffNevermind      = 1
    local turnOffApply          = 2
    local turnOffSystemInfo     = 4
    local turnOffDungeonInfo    = 8
    local turnOffOptionToPay    = 16
    local turnOffAskingForWork  = 32

    if ENABLE_SOA == 0 then
        player:startEvent(10124)
    elseif rumorsFromTheWest then
        player:startEvent(10117, 0, turnOffDungeonInfo + turnOffAskingForWork)
    elseif theGeomagnetron and player:getCharVar("SOA") == 1 then
        player:startEvent(10118)
    elseif theGeomagnetron then
        player:startEvent(10117, 1, turnOffAskingForWork)
    else
        player:startEvent(10123)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10117 and option == 1 then -- accepted geomagnetron
        -- Clear option CS flags
        player:setCharVar("SOA_1_CS1", 0)
        player:setCharVar("SOA_1_CS2", 0)
        player:setCharVar("SOA_1_CS3", 0)

        npcUtil.giveKeyItem(player, xi.ki.GEOMAGNETRON)

        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON)
    elseif
        (csid == 10117 and option == 2) or -- paid
        csid == 10118  -- quest complete
    then
        -- Clear option CS flags
        player:setCharVar("SOA_1_CS1", 0)
        player:setCharVar("SOA_1_CS2", 0)
        player:setCharVar("SOA_1_CS3", 0)

        if option == 2 then player:delGil(1000000) end

        player:delKeyItem(xi.ki.GEOMAGNETRON)
        npcUtil.giveKeyItem(player, xi.ki.GEOMAGNETRON)
        npcUtil.giveKeyItem(player, xi.ki.ADOULINIAN_CHARTER_PERMIT)

        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.THE_GEOMAGNETRON)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ONWARD_TO_ADOULIN)

        player:setCharVar("SOA", 0)
    end
end

return entity
