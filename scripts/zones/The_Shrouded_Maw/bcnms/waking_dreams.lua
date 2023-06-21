-----------------------------------
-- Waking Dreams
-- The Shrouded Maw avatar battlefield
-- !addkeyitem VIAL_OF_DREAM_INCENSE
-----------------------------------
local ID = require("scripts/zones/The_Shrouded_Maw/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/titles")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    local inst = battlefield:getArea()
    local tile = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (inst - 1) * 8
    for i = tile, tile + 7 do
        GetNPCByID(i):setAnimation(xi.anim.CLOSE_DOOR)
    end
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
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
        if player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE) then
            player:delKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE)
            player:addKeyItem(xi.ki.WHISPER_OF_DREAMS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPER_OF_DREAMS)
        end

        player:addTitle(xi.title.HEIR_TO_THE_REALM_OF_DREAMS)
    end
end

return battlefieldObject
