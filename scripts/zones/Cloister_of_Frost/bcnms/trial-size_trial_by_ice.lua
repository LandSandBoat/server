-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Trial-size Trial by Ice
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Frost/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/quests")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:setCharVar("TrialSizeIce_date", tonumber(os.date("%j"))) -- If you lose, you need to wait 1 real day
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if not player:hasSpell(302) then
            player:addSpell(302)
            player:messageSpecial(ID.text.SHIVA_UNLOCKED, 0, 0, 4)
        end
        if not player:hasItem(4181) then
            player:addItem(4181) -- Scroll of instant warp
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4181)
        end
        player:setCharVar("TrialSizeIce_date", 0)
        player:addFame(SANDORIA, 30)
        player:completeQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.TRIAL_SIZE_TRIAL_BY_ICE)
    end
end
