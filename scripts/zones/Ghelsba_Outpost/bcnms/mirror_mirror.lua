
-----------------------------------
-- Area: Ghelsba Outpost
-- Name: Mirror Mirror - Adventuring Fellow Quest
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
require("scripts/globals/battlefield")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/pets")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

-- Physically entering the BCNM via bcnmEnter(bcnmid)
battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    local fellowParam = xi.fellow_utils.getFellowParam(player)

    if leavecode == xi.battlefield.leaveCode.WON then --play end CS. Need time and battle id for record keeping + storage
        local _, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), battlefield:getLocalVar("[cs]bit"), 5, 0, fellowParam)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
    -- no fellows outside the bcnm
    if csid == 32001 or csid == 32002 then
        if player:getFellow() ~= nil then
            player:despawnFellow()
        end
    end

    if csid == 32001 then
        local fellowParam = xi.fellow_utils.getFellowParam(player)
        player:updateEvent(140, 0, 5, 197, 0, 1048578, 0, fellowParam)
    end

    if csid == 32004 then
        local fellowParam = xi.fellow_utils.getFellowParam(player)
        player:updateEvent(140, 0, 5, 0, 0, 1048578, 0, fellowParam)
        local mob = GetMobByID(ID.mob.CARRION_DRAGON)
        mob:setStatus(xi.status.INVISIBLE)
    end
end

battlefieldObject.onEventFinish = function(player, csid, option)
    if
        csid == 32001 and
        option ~= 0 and
        player:getCharVar("[Quest]Mirror_Mirror") == 2
    then
        player:setCharVar("[Quest]Mirror_Mirror", 3)
    end

    if
        csid == 32001 or
        csid == 32002
    then
        SetServerVariable("[Mirror_Mirror]BCNMmobHP", 0)
    end

    if csid == 32004 then
        DespawnMob(ID.mob.CARRION_DRAGON)
        SpawnMob(ID.mob.CARRION_DRAGON + 1)
        local mob = GetMobByID(ID.mob.CARRION_DRAGON + 1)
        mob:setHP(GetServerVariable("[Mirror_Mirror]BCNMmobHP"))
        mob:setPos(-189, -10, 42)

        player:setLocalVar("triggerFellow", 1) -- no greeting on spawn
        player:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
        player:spawnFellow(player:getFellowValue("fellowid"))
        player:getFellow():setPos(-197, -10, 40.5)
        player:timer(20000, function(playerArg)
            playerArg:fellowAttack(mob)
        end)
    end
end

return battlefieldObject
