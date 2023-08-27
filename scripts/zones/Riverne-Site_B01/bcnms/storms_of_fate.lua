-----------------------------------
-- Area: Riverne Site #B01
-- Name: Storms of Fate
-- !pos 299 -123 345 146
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION) -- can't be capped at 50 for this fight !
    player:timer (1000, function(playerArg) playerArg:setHP(playerArg:getMaxHP()) playerArg:setMP(playerArg:getMaxMP()) end)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        if
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and
            player:getCharVar('Quest[3][86]Status') == 2
        then
            player:addKeyItem(xi.ki.WHISPER_OF_THE_WYRMKING)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPER_OF_THE_WYRMKING)
            player:setCharVar("Quest[3][86]Status", 3)
            player:addTitle(xi.title.CONQUEROR_OF_FATE)
        end
        if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
            player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    elseif csid == 32002 then
        if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
            player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    end
end

return battlefieldObject
