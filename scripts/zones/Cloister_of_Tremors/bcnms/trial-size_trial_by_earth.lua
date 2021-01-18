-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: Trial-size Trial by Earth
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Tremors/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/quests")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:setCharVar("TrialSizeEarth_date", tonumber(os.date("%j"))) -- If you lose, you need to wait 1 real day
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if not player:hasSpell(299) then
            player:addSpell(299)
            player:messageSpecial(ID.text.TITAN_UNLOCKED, 0, 0, 1)
        end
        if not player:hasItem(4181) then
            player:addItem(4181) -- Scroll of instant warp
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4181)
        end
        player:setCharVar("TrialSizeEarth_date", 0)
        player:addFame(BASTOK, 30)
        player:completeQuest(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)
    end
end

return battlefield_object
