-----------------------------------
-- Area: Cloister of Flames
-- BCNM: Trial-size Trial by Fire
-----------------------------------
local ID = zones[xi.zone.CLOISTER_OF_FLAMES]
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
        local arg8 = (player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_FIRE) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
    if csid == 32001 then
        if not player:hasSpell(xi.magic.spell.IFRIT) then
            player:addSpell(xi.magic.spell.IFRIT)
            player:messageSpecial(ID.text.IFRIT_UNLOCKED, 0, 0, 0)
        end

        if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
            player:addItem(xi.item.SCROLL_OF_INSTANT_WARP)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_INSTANT_WARP)
        end

        player:addFame(xi.quest.fame_area.WINDURST, 30)
        player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_FIRE)
    end
end

return battlefieldObject
