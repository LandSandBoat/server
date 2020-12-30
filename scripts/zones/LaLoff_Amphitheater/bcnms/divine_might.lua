-----------------------------------
-- Area: LaLoff Amphitheater
-- Name: Divine Might
--[[ caps:
    7d01, 0, 529, 1, 950, 180, 6, 0, 0 --Neo AA HM
    7d01, 0, 1400, 5, 1400, 180, 11, 0, 0  --Neo DM
    7d01, 1, 405, 1, 1599, 180, 7, 0, 0 -- Neo AA TT
    7d01, 1, 378, 3, 903, 180, 8, 0, 0 -- Neo AA MR
    7d02, 0, 80, 1, 512, 4, 4, 180 -- Neo DM (lose)
]]
-----------------------------------
local ID = require("scripts/zones/LaLoff_Amphitheater/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 1)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.ARK_ANGELS)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 180, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002, 0, 0, 0, 0, 0, battlefield:getArea(), 180)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT) == QUEST_ACCEPTED then
            player:setCharVar("DivineMight", 2) -- Used to use 2 to track completion, so that's preserved to maintain compatibility
            for i = tpz.ki.SHARD_OF_APATHY, tpz.ki.SHARD_OF_RAGE do
                player:addKeyItem(i)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, i)
            end
            if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.ARK_ANGELS then
                player:completeMission(ZILART, tpz.mission.id.zilart.ARK_ANGELS)
                player:addMission(ZILART, tpz.mission.id.zilart.THE_SEALED_SHRINE)
                player:setCharVar("ZilartStatus", 0)
            end
        elseif player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.DIVINE_MIGHT_REPEAT) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.MOONLIGHT_ORE) then
            player:setCharVar("DivineMight", 2)
        end
    end
end
