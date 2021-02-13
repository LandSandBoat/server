-----------------------------------
-- Area: Cloister of Tides
-- BCNM: Trial-size Trial by Water
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Tides/IDs")
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
        local arg8 = (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if not player:hasSpell(300) then
            player:addSpell(300)
            player:messageSpecial(ID.text.LEVIATHAN_UNLOCKED, 0, 0, 2)
        end
        if not player:hasItem(4181) then
            player:addItem(4181) -- Scroll of instant warp
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4181)
        end
        player:addFame(NORG, 30)
        player:completeQuest(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WATER)
    end
end

return battlefield_object
