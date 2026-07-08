-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Silver Beastcoin Door
-- !pos 280 18.549 -100 176
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- The coin isn't consumed, so we only need to know if one was in the trade window
    if trade:getItemQty(xi.item.SILVER_BEASTCOIN) > 0 then
        if player:getCharVar('SSG_SilverDoor') == 7 then
            npc:openDoor(5) -- Open the door if a silver beastcoin has been traded after checking the door the required number of times
        end
    end
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()
    local silverDoorCheck = player:getCharVar('SSG_SilverDoor')

    if xPos <= 280 and zPos >= -104 then
        if silverDoorCheck == 0 then -- Door has never been checked
            player:messageSpecial(ID.text.FIRST_CHECK)
            player:setCharVar('SSG_SilverDoor', 1)
        elseif silverDoorCheck == 1 then -- Door has been checked once
            player:messageSpecial(ID.text.SECOND_CHECK)
            player:setCharVar('SSG_SilverDoor', 2)
        elseif silverDoorCheck == 2 then -- Door has been checked twice
            player:messageSpecial(ID.text.THIRD_CHECK)
            player:setCharVar('SSG_SilverDoor', 3)
        elseif silverDoorCheck == 3 then -- Door has been checked three times
            player:messageSpecial(ID.text.FOURTH_CHECK)
            player:setCharVar('SSG_SilverDoor', 4)
        elseif silverDoorCheck == 4 then -- Door has been checked four times
            player:messageSpecial(ID.text.FIFTH_CHECK)
            player:setCharVar('SSG_SilverDoor', 5)
        elseif silverDoorCheck == 5 then -- Door has been checked five times
            player:messageSpecial(ID.text.SILVER_CHECK)
            player:setCharVar('SSG_SilverDoor', 6)
        elseif silverDoorCheck == 6 or silverDoorCheck == 7 then -- Door has been checked six or more times
            player:messageSpecial(ID.text.COMPLETED_CHECK, xi.item.SILVER_BEASTCOIN)
            player:setCharVar('SSG_SilverDoor', 7)
        end
    elseif xPos > 280 and zPos < -100 then
        return -1 -- Open the door if coming from the 'inside'
    end
end

return entity
