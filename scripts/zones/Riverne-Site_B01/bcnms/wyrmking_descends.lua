-----------------------------------
-- The Wyrmking Descends
-- Riverne Site B, Monarchs Orb
-- !pos -610 4 690 29
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION) -- can't be capped at 50 for this fight !
    player:timer (1000, function(playerArg) playerArg:setHP(playerArg:getMaxHP()) playerArg:setMP(playerArg:getMaxMP()) end)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (not player:hasKeyItem(xi.ki.WHISPER_OF_THE_WYRMKING)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addTitle(xi.title.WYRM_ASTONISHER)
        if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
            player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    elseif csid == 32002 then
        if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
            player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0)
        end
    end
end

return battlefield_object
