-----------------------------------
-- Sheep in Antlion's Clothing
-- Boneyard Gully ENM, Miasma Filter
-- !addkeyitem MIASMA_FILTER
-----------------------------------
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldInitialise = function(battlefield)
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
    local Tuchulcha = GetMobByID(ID.sheepInAntlionsClothing[bfID].TUCHULCHA_ID)
    Tuchulcha:setLocalVar('sand_pit1', pos[4])
    Tuchulcha:setLocalVar('sand_pit2', pos[5])
    Tuchulcha:setLocalVar('sand_pit3', pos[6])
end

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
    if player:hasKeyItem(xi.ki.MIASMA_FILTER) then
        player:delKeyItem(xi.ki.MIASMA_FILTER)
    end
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:addExp(2500)
    end
end

return battlefield_object
