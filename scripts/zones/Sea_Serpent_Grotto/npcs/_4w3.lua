-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Mythril Beastcoin Door
-- !pos 40 8.6 20.012 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 749) then
        if player:getCharVar("SSG_MythrilDoor") == 7 then
            npc:openDoor(5) -- Open the door if a mythril beastcoin has been traded after checking the door the required number of times
        end
    end
end

entity.onTrigger = function(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()
    local MythrilDoorCheck = player:getCharVar("SSG_MythrilDoor")

    if X >= 40  and Z >= 15 then
        if MythrilDoorCheck == 0 then -- Door has never been checked
            player:messageSpecial(ID.text.FIRST_CHECK)
            player:setCharVar("SSG_MythrilDoor", 1)
        elseif MythrilDoorCheck == 1 then -- Door has been checked once
            player:messageSpecial(ID.text.SECOND_CHECK)
            player:setCharVar("SSG_MythrilDoor", 2)
        elseif MythrilDoorCheck == 2 then -- Door has been checked twice
            player:messageSpecial(ID.text.THIRD_CHECK)
            player:setCharVar("SSG_MythrilDoor", 3)
        elseif MythrilDoorCheck == 3 then -- Door has been checked three times
            player:messageSpecial(ID.text.FOURTH_CHECK)
            player:setCharVar("SSG_MythrilDoor", 4)
        elseif MythrilDoorCheck == 4 then -- Door has been checked four times
            player:messageSpecial(ID.text.FIFTH_CHECK)
            player:setCharVar("SSG_MythrilDoor", 5)
        elseif MythrilDoorCheck == 5 then -- Door has been checked five times
            player:messageSpecial(ID.text.MYTHRIL_CHECK)
            player:setCharVar("SSG_MythrilDoor", 6)
        elseif MythrilDoorCheck == 6 or MythrilDoorCheck == 7 then -- Door has been checked six or more times
            player:messageSpecial(ID.text.COMPLETED_CHECK, 749)
            player:setCharVar("SSG_MythrilDoor", 7)
        end

        return 1 -- Keep the door closed
    elseif X < 40 and Z < 24 then
        return -1 -- Open the door if coming from the "inside"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
