-----------------------------------
-- Shattering Stars
-- Qu'Bia Arena Maat battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
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
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addTitle(xi.title.MAAT_MASHER)

        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) == QUEST_ACCEPTED then
            npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
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
