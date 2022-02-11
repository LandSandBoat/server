-----------------------------------
-- Area: Sealion's Den
-- Name: One to be Feared
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("phaseChange", 1) -- Prevent battlefield from being completed until we want to.
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getCurrentMission(COP) ~= xi.mission.id.cop.ONE_TO_BE_FEARED or player:getCharVar("PromathiaStatus") ~= 2) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)

    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    -- NOTE: On completion, all members are sent back to Sealion's Den.
    --       If you're eligable for the cutscene when you zone in, you'll be sent to Lufaise directly afterwards.
    if csid == 32001 then
        if player:getCurrentMission(COP) == xi.mission.id.cop.ONE_TO_BE_FEARED and player:getCharVar("PromathiaStatus") == 3 then
            player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)
            player:setCharVar("PromathiaStatus", 0)
            player:startEvent(33)
        end
        player:addExp(1500)
    elseif csid == 33 then
        player:setPos(438, 0, -18, 11, xi.zone.LUFAISE_MEADOWS)
    end
end

return battlefield_object
