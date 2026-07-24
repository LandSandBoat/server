-----------------------------------
-- Zone: Halvung (62)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
-----------------------------------

local halvungGlobal = {}

halvungGlobal.playersRequiredPerDoor =
{
    [ID.npc.LEVER_AB_DOOR] = 6,
    [ID.npc.LEVER_CD_DOOR] = 6,
    [ID.npc.LEVER_EF_DOOR] = 6,
    [ID.npc.LEVER_GH_DOOR] = 6,
    [ID.npc.LEVER_IJ_DOOR] = 6,
}
    
--  used for when a player triggers an Operating Lever
halvungGlobal.operatingLeverOnTrigger  = function(player, npc, doorNpcId)
    -- Check if door is open first
    -- Cap what happens when door is open
    if player:hasKeyItem(xi.ki.BRACELET_OF_VERVE) then
        GetNPCByID(doorNpcId):openDoor(30)
        player:messageSpecial(ID.text.LIFT_LEVER)
    else
        npc:messageName(ID.text.BEGINS_PUSHING_THE_LEVER, player)
        player:startEvent(100)
        -- if both levers work together - set this on the Door
        npc:setLocalVar('playerCount', npc:getLocalVar('playerCount') + 1)
    end
end

-- used for when an Operating Lever event completes
halvungGlobal.operatingLeverOnEventFinish = function(player, csid, option, npc, doorNpcId)
-- How does this work for multiple events firing at once?
    if npc:getLocalVar('playerCount') > halvungGlobal.playersRequiredPerDoor[doorNpcId] then
        GetNPCByID(doorNpcId):openDoor(30)
    end

    npc:messageName(ID.text.RELEASES_THE_LEVER, player)
    npc:setLocalVar('playerCount', npc:getLocalVar('playerCount') - 1)
end

return halvungGlobal
