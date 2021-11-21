-----------------------------------
-- Area: Davoi
--  NPC: Sedal-Godjal
-- Involved in Quests: Whence the Wind Blows
-- Involved in Missions: Windurst 8-1/8-2
-- !pos 185 -3 -116 149
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Whence Blows the Wind
    if player:hasKeyItem(xi.ki.CRIMSON_ORB) == false then
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
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- Whence Blows the Wind
    if csid == 22 and option == 1 then
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
