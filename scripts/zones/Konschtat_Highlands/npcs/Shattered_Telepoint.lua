-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Shattered telepoint
-- !pos 135 19 220 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- RoV Missions
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.THE_PATH_UNTRAVELED and player:getRank() >= 3 then
        player:startEvent(3)
    elseif player:getCharVar("LionIICipher") == 1 then
        if npcUtil.giveItem(player, 10159) then -- Cipher: Lion II
            npcUtil.giveKeyItem(player, tpz.ki.RHAPSODY_IN_UMBER)
            player:completeMission(ROV, tpz.mission.id.rov.A_LAND_AFTER_TIME)
            player:addMission(ROV, tpz.mission.id.rov.FATES_CALL)
            player:setCharVar("LionIICipher", 0)
        end
    elseif player:getCurrentMission(ROV) == tpz.mission.id.rov.A_LAND_AFTER_TIME then
        local rank6 = (player:getRank(player:getNation()) >= 6) and 1 or 0
        player:startEvent(4, player:getZoneID(), 0, 0, 0, 0, 0, rank6)

    -- CoP Missions
    elseif player:getCurrentMission(COP) == tpz.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 1 then
        player:startEvent(913, 0, 0, 1) -- first time in promy -> have you made your preparations cs
    elseif
        player:getCurrentMission(COP) == tpz.mission.id.cop.THE_MOTHERCRYSTALS and
        (player:hasKeyItem(tpz.ki.LIGHT_OF_HOLLA) or player:hasKeyItem(tpz.ki.LIGHT_OF_MEA))
    then
        if player:getCharVar("cspromy2") == 1 then
            player:startEvent(912)  -- cs you get nearing second promyvion
        else
            player:startEvent(913)
        end
    elseif
        player:getCurrentMission(COP) > tpz.mission.id.cop.THE_MOTHERCRYSTALS or
        player:hasCompletedMission(COP, tpz.mission.id.cop.THE_LAST_VERSE) or
        (player:getCurrentMission(COP) == tpz.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") > 1)
    then
        player:startEvent(913) -- normal cs (third promyvion and each entrance after having that promyvion visited or mission completed)

    -- Default Message
    else
        player:messageSpecial(ID.text.TELEPOINT_HAS_BEEN_SHATTERED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- RoV Missions
    if csid == 3 then
        player:completeMission(ROV, tpz.mission.id.rov.THE_PATH_UNTRAVELED)
        player:addMission(ROV, tpz.mission.id.rov.AT_THE_HEAVENS_DOOR)
    elseif csid == 4 then
        if npcUtil.giveItem(player, 10159) then -- Cipher: Lion II
            npcUtil.giveKeyItem(player, tpz.ki.RHAPSODY_IN_UMBER)
            player:completeMission(ROV, tpz.mission.id.rov.A_LAND_AFTER_TIME)
            player:addMission(ROV, tpz.mission.id.rov.FATES_CALL)
        else
            player:setCharVar("LionIICipher", 1)
        end

    -- CoP Missions
    elseif csid == 912 then
        player:setCharVar("cspromy2", 0)
        player:setCharVar("cs2ndpromy", 1)
        player:setPos(185.891, 0, -52.331, 128, 18) -- To Promyvion Dem
    elseif csid == 913 and option == 0 then
        player:setPos(-267.194, -40.634, -280.019, 0, 14) -- To Hall of Transference {R}
    end
end
