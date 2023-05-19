-----------------------------------
-- Undying Promise
-- Qu'Bia Arena BCNM40, Star Orb
-- !additem 1131
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------

local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    -- initialize the re-raise value, starts at 1 because it's not evaluated until the first mob dies.
    battlefield:setLocalVar("reraise", 1)
    -- this does not spawn the loot, but prevents battlefield from ending when you kill the still-to-reraise mob
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("lootSpawned", 1)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)

    -- Need to check if players have left the battlefield by warping
    -- or otherwise. If they have, make sure the cleanup and respawn
    local players = battlefield:getPlayers()
    if #players < 1 then
        battlefield:lose()
        battlefield:cleanup(true)
    end
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    -- initialize the re-raise value, starts at 1 because it's not evaluated until the first mob dies.
    battlefield:setLocalVar("reraise", 1)
    -- this does not spawn the loot, but prevents battlefield from ending when you kill the still-to-reraise mob
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("lootSpawned", 1)
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
end

return battlefieldObject
