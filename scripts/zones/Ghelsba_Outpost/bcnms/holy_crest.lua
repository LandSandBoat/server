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
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) ~= QUEST_ACCEPTED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 and option ~= 0 and player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY) then
        npcUtil.completeQuest(player, SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST, {
            title = xi.title.HEIR_TO_THE_HOLY_CREST,
            var = "TheHolyCrest_Event",
        })
        player:delKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
        player:unlockJob(xi.job.DRG)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_DRAGOON)
        player:setPetName(xi.pet.type.WYVERN, option + 1)
    end
end

return battlefield_object
