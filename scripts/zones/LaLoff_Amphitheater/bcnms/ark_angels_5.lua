-----------------------------------
-- Area: LaLoff Amphitheater
-- Name: Ark Angels 5 (Galka)
-----------------------------------
local ID = require("scripts/zones/LaLoff_Amphitheater/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
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
        local arg8 = (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.ARK_ANGELS)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 180, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002, 0, 0, 0, 0, 0, battlefield:getArea(), 180)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        if player:getCurrentMission(ZILART) == tpz.mission.id.zilart.ARK_ANGELS and player:getCharVar("ZilartStatus") == 1 then
            player:addKeyItem(tpz.ki.SHARD_OF_RAGE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHARD_OF_RAGE)
            if
                player:hasKeyItem(tpz.ki.SHARD_OF_APATHY) and
                player:hasKeyItem(tpz.ki.SHARD_OF_ARROGANCE) and
                player:hasKeyItem(tpz.ki.SHARD_OF_COWARDICE) and
                player:hasKeyItem(tpz.ki.SHARD_OF_ENVY) and
                player:hasKeyItem(tpz.ki.SHARD_OF_RAGE)
            then
                player:completeMission(ZILART, tpz.mission.id.zilart.ARK_ANGELS)
                player:addMission(tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_SEALED_SHRINE)
                player:setCharVar("ZilartStatus", 0)
            end
        end
    end
end
