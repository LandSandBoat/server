-----------------------------------
-- Shattering Stars
-- Qu'Bia Arena Maat battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
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
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addTitle(tpz.title.MAAT_MASHER)

        if player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS) == QUEST_ACCEPTED then
            npcUtil.giveItem(player, 4181) -- scroll_of_instant_warp
        end

        local maatsCap = player:getCharVar("maatsCap")
        local pjob = player:getMainJob()
        player:setCharVar("maatDefeated", pjob)
        if not utils.mask.getBit(maatsCap, pjob - 1) then
            player:setCharVar("maatsCap", utils.mask.setBit(maatsCap, pjob - 1, true))
        end
    end
end

return battlefield_object
