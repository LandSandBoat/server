-----------------------------------
-- Requiem of Sin
-- Boneyard Gully Quest Battlefield, KI: Letter from Shikaree Y / Letter from Mithran Trackers
-- !addkeyitem LETTER_FROM_SHIKAREE_Y / LETTER_FROM_MITHRAN_TRACKERS
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    if player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y) then
        player:delKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y)
    elseif player:hasKeyItem(xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS) then
        player:delKeyItem(xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS)
    end
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addTitle(xi.title.DISCIPLE_OF_JUSTICE)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.REQUIEM_OF_SIN)
    elseif csid == 32002 then
        -- Allow player to get new key item
        player:setCharVar("Quest[4][84]conquestRequiem", 0)
    end
end

return battlefieldObject
