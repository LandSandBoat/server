-----------------------------------
-- Holy Crest
-- Ghelsba Outpost DRG quest battlefield
-- !pos -162 -11 78 140
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) ~= QUEST_ACCEPTED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
    if
        csid == 32001 and
        option ~= 0 and
        player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
    then
        npcUtil.completeQuest(player, xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST, {
            title = xi.title.HEIR_TO_THE_HOLY_CREST,
            var = 'TheHolyCrest_Event',
        })
        player:delKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
        player:unlockJob(xi.job.DRG)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_DRAGOON)
        player:setPetName(xi.petType.WYVERN, option + 1)
    end
end

return battlefieldObject
