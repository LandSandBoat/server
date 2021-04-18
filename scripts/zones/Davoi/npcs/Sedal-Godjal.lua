-----------------------------------
-- Area: Davoi
--  NPC: Sedal-Godjal
-- Involved in Quests: Whence the Wind Blows
-- Involved in Missions: Windurst 8-1/8-2
-- !pos 185 -3 -116 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Vain (Windurst 8-1)
    if
        npcUtil.tradeHas(trade, 17437) and -- Curse Wand
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and
        player:getMissionStatus(player:getNation()) == 3 and
        player:hasKeyItem(xi.ki.MAGIC_DRAINED_STAR_SEEKER)
    then
        player:startEvent(120)
    end
end

entity.onTrigger = function(player, npc)
    local currentMission = player:getCurrentMission(WINDURST)
    local missionStatus = player:getMissionStatus(player:getNation())

    -- The Jester Who'd Be King (Windurst 8-2)
    if
        currentMission == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and
        player:getMissionStatus(player:getNation()) == 1 and not
        player:hasKeyItem(xi.ki.AURASTERY_RING)
    then
        player:startEvent(122, 0, xi.ki.AURASTERY_RING)

    -- Vain (Windurst 8-1)
    elseif currentMission == xi.mission.id.windurst.VAIN and missionStatus >= 2 then -- wiki says it doesnt matter whether you get cs or kill first
        if player:hasKeyItem(xi.ki.STAR_SEEKER) == true then
            player:startEvent(118, 0, 17437, xi.ki.STAR_SEEKER)
        elseif player:hasKeyItem(xi.ki.MAGIC_DRAINED_STAR_SEEKER) and missionStatus == 4 then
            player:startEvent(121)
        else
            player:startEvent(119, 0, 17437)
        end

    -- Whence Blows the Wind
    elseif player:hasKeyItem(xi.ki.CRIMSON_ORB) == false then
        local miniQuestForORB_CS = player:getCharVar("miniQuestForORB_CS")

        if miniQuestForORB_CS == 0 then
            player:startEvent(24)
        elseif miniQuestForORB_CS == 99 then
            player:startEvent(22) -- Start mini quest
        elseif miniQuestForORB_CS == 1 and player:getCharVar("countRedPoolForORB") ~= 15 then
            player:startEvent(21) -- During mini quest
        elseif miniQuestForORB_CS == 1 then
            player:startEvent(25, 0, 0, 0, xi.ki.CRIMSON_ORB) -- Finish mini quest
        end

    -- Standard dialog
    else
        player:startEvent(24)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- The Jester Who'd Be King (Windurst 8-2)
    if csid == 122 and npcUtil.giveKeyItem(player, xi.ki.AURASTERY_RING) then
        if player:hasKeyItem(xi.ki.RHINOSTERY_RING) and player:hasKeyItem(xi.ki.OPTISTERY_RING) then
            player:setMissionStatus(player:getNation(), 2)
        end

    -- Vain (Windurst 8-1)
    elseif csid == 118 then
        player:delKeyItem(xi.ki.STAR_SEEKER)
        npcUtil.giveKeyItem(player, xi.ki.MAGIC_DRAINED_STAR_SEEKER)
        player:setMissionStatus(player:getNation(), 3)
    elseif csid == 120 then
        player:tradeComplete()
        player:setMissionStatus(player:getNation(), 4)

    -- Whence Blows the Wind
    elseif csid == 22 and option == 1 then
        player:setCharVar("miniQuestForORB_CS", 1)
        npcUtil.giveKeyItem(player, xi.ki.WHITE_ORB)
    elseif csid == 25 then
        player:setCharVar("miniQuestForORB_CS", 0)
        player:setCharVar("countRedPoolForORB", 0)
        player:delKeyItem(xi.ki.CURSED_ORB)
        npcUtil.giveKeyItem(player, xi.ki.CRIMSON_ORB)
    end
end

return entity
