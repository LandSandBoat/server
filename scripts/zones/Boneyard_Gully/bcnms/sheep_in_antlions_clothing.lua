-----------------------------------
-- Sheep in Antlion's Clothing
-- Boneyard Gully ENM, Miasma Filter
-- !addkeyitem MIASMA_FILTER
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar("loot", 1)

    -- Used to grab the mob IDs
    local bfID = battlefield:getArea()

    -- Shuffle the possible coords to randomize antlion positions
    local pos = utils.permgen(#ID.sheepInAntlionsClothing[bfID].ant_positions)

    -- Set the hunter spawn positions
    GetMobByID(ID.sheepInAntlionsClothing[bfID].SWIFT_HUNTER_ID):setPos(ID.sheepInAntlionsClothing[bfID].ant_positions[pos[1]]) -- Swift Hunter
    GetMobByID(ID.sheepInAntlionsClothing[bfID].SHREWD_HUNTER_ID):setPos(ID.sheepInAntlionsClothing[bfID].ant_positions[pos[2]]) -- Shrewd Hunter
    GetMobByID(ID.sheepInAntlionsClothing[bfID].ARMORED_HUNTER_ID):setPos(ID.sheepInAntlionsClothing[bfID].ant_positions[pos[3]]) -- Armored Hunter

    -- Select Tuchulcha's sandpit positions
    local tuchulcha = GetMobByID(ID.sheepInAntlionsClothing[bfID].TUCHULCHA_ID)
    tuchulcha:setLocalVar('sand_pit1', pos[4])
    tuchulcha:setLocalVar('sand_pit2', pos[5])
    tuchulcha:setLocalVar('sand_pit3', pos[6])
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
    if player:hasKeyItem(xi.ki.MIASMA_FILTER) then
        player:delKeyItem(xi.ki.MIASMA_FILTER)
    end
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
        player:addExp(2500)
    end
end

return battlefieldObject
