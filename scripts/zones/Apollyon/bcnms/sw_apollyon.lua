-----------------------------------
-- Area: Appolyon
-- Name: SW Apollyon
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)
    battlefield:setLocalVar("lootSpawned", 1)
    SetServerVariable("[SW_Apollyon]Time", battlefield:getTimeLimit() / 60)
    xi.limbus.handleDoors(battlefield)

    local random = math.random(0, 7)
    battlefield:setLocalVar("timePH", ID.npc.APOLLYON_SW_CRATE[3] + random)
    battlefield:setLocalVar("restorePH", ID.npc.APOLLYON_SW_CRATE[3] + random + 1)
    battlefield:setLocalVar("itemPH", ID.npc.APOLLYON_SW_CRATE[3] + random + 2)

    -- Since this BC does not have a default "kill to win" mob set in the database like the other Apollyons
    -- We have to manage it with this phaseChange variable. This allows the "kill to win" mobs to be the
    -- elementals that correspond with the day you enter
    battlefield:setLocalVar("phaseChange", 1)

    xi.limbus.setupArmouryCrates(battlefield:getID())
end

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    if battlefield:getRemainingTime() % 60 == 0 then
        SetServerVariable("[SW_Apollyon]Time", battlefield:getRemainingTime() / 60)
    end

    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
    player:delKeyItem(xi.ki.COSMO_CLEANSE)
    player:delKeyItem(xi.ki.RED_CARD)
    player:setCharVar("Cosmo_Cleanse_TIME", os.time())

    -- Set race of first player that enters the battlefield
    if battlefield:getLocalVar("raceF1") == 0 then
        local playerRace = player:getRace()

        -- 1 or 2 = Hume (ID 1); 3 or 4 = Elvaan (ID 2); 5 or 6 = Taru (ID 3)
        if playerRace <= 6 then
            playerRace = math.ceil(playerRace / 2)
        -- 7 = Mithra (ID 4); 8 = Galka (ID 5)
        else
            playerRace = playerRace - 3
        end

        battlefield:setLocalVar("raceF1", playerRace)
    end
end

battlefield_object.onBattlefieldDestroy = function(battlefield)
    xi.limbus.handleDoors(battlefield, true)
    SetServerVariable("[SW_Apollyon]Time", 0)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    player:messageSpecial(ID.text.HUM + 1)

    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        player:startCutscene(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startCutscene(32002)
    end
end

return battlefield_object
