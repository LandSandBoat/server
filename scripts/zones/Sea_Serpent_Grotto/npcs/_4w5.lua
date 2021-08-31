-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Silver Beastcoin Door
-- !pos 280 18.549 -100 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 750) then
        if player:getCharVar("SSG_SilverDoor") == 7 then
            npc:openDoor(5) -- Open the door if a silver beastcoin has been traded after checking the door the required number of times
        end
    end
end

entity.onTrigger = function(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()
    local SilverDoorCheck = player:getCharVar("SSG_SilverDoor")

    if X <= 280 and Z >= -104 then
        if SilverDoorCheck == 0 then -- Door has never been checked
            player:messageSpecial(ID.text.FIRST_CHECK)
            player:setCharVar("SSG_SilverDoor", 1)
        elseif SilverDoorCheck == 1 then -- Door has been checked once
            player:messageSpecial(ID.text.SECOND_CHECK)
            player:setCharVar("SSG_SilverDoor", 2)
        elseif SilverDoorCheck == 2 then -- Door has been checked twice
            player:messageSpecial(ID.text.THIRD_CHECK)
            player:setCharVar("SSG_SilverDoor", 3)
        elseif SilverDoorCheck == 3 then -- Door has been checked three times
            player:messageSpecial(ID.text.FOURTH_CHECK)
            player:setCharVar("SSG_SilverDoor", 4)
        elseif SilverDoorCheck == 4 then -- Door has been checked four times
            player:messageSpecial(ID.text.FIFTH_CHECK)
            player:setCharVar("SSG_SilverDoor", 5)
        elseif SilverDoorCheck == 5 then -- Door has been checked five times
            player:messageSpecial(ID.text.SILVER_CHECK)
            player:setCharVar("SSG_SilverDoor", 6)
        elseif SilverDoorCheck == 6 or SilverDoorCheck == 7 then -- Door has been checked six or more times
            player:messageSpecial(ID.text.COMPLETED_CHECK, 750)
            player:setCharVar("SSG_SilverDoor", 7)
        end

        return 1 -- Keep the door closed
    elseif X > 280 and Z < -100 then
        return -1 -- Open the door if coming from the "inside"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
