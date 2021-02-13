-----------------------------------
-- Waking Dreams
-- The Shrouded Maw avatar battlefield
-- !addkeyitem VIAL_OF_DREAM_INCENSE
-----------------------------------
local ID = require("scripts/zones/The_Shrouded_Maw/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldInitialise = function(battlefield)
    local inst = battlefield:getArea()
    local tile = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (inst - 1) * 8
    for i = tile, tile + 7 do
        GetNPCByID(i):setAnimation(tpz.anim.CLOSE_DOOR)
    end
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
        if player:hasKeyItem(tpz.ki.VIAL_OF_DREAM_INCENSE) then
            player:delKeyItem(tpz.ki.VIAL_OF_DREAM_INCENSE)
            player:addKeyItem(tpz.ki.WHISPER_OF_DREAMS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.WHISPER_OF_DREAMS)
        end
        player:addTitle(tpz.title.HEIR_TO_THE_REALM_OF_DREAMS)
    end
end

return battlefield_object
