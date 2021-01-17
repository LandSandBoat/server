-----------------------------------
-- Holy Crest
-- Ghelsba Outpost DRG quest battlefield
-- !pos -162 -11 78 140
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/pets")
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
        local arg8 = (player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST) ~= QUEST_ACCEPTED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 and option ~= 0 and player:hasKeyItem(tpz.ki.DRAGON_CURSE_REMEDY) then
        npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST, {
            title = tpz.title.HEIR_TO_THE_HOLY_CREST,
            var = "TheHolyCrest_Event",
        })
        player:delKeyItem(tpz.ki.DRAGON_CURSE_REMEDY)
        player:unlockJob(tpz.job.DRG)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_DRAGOON)
        player:setPetName(tpz.pet.type.WYVERN, option + 1)
    end
end

return battlefield_object
