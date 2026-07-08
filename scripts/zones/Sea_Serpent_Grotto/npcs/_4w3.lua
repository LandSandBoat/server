-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Mythril Beastcoin Door
-- !pos 40 8.6 20.012 176
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- The coin isn't consumed, so we only need to know if one was in the trade window
    if trade:getItemQty(xi.item.MYTHRIL_BEASTCOIN) > 0 then
        if player:getCharVar('SSG_MythrilDoor') == 7 then
            npc:openDoor(5) -- Open the door if a mythril beastcoin has been traded after checking the door the required number of times
        end
    end
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()
    local mythrilDoorCheck = player:getCharVar('SSG_MythrilDoor')

    if xPos >= 40 and zPos >= 15 then
        if mythrilDoorCheck == 0 then -- Door has never been checked
            player:messageSpecial(ID.text.FIRST_CHECK)
            player:setCharVar('SSG_MythrilDoor', 1)
        elseif mythrilDoorCheck == 1 then -- Door has been checked once
            player:messageSpecial(ID.text.SECOND_CHECK)
            player:setCharVar('SSG_MythrilDoor', 2)
        elseif mythrilDoorCheck == 2 then -- Door has been checked twice
            player:messageSpecial(ID.text.THIRD_CHECK)
            player:setCharVar('SSG_MythrilDoor', 3)
        elseif mythrilDoorCheck == 3 then -- Door has been checked three times
            player:messageSpecial(ID.text.FOURTH_CHECK)
            player:setCharVar('SSG_MythrilDoor', 4)
        elseif mythrilDoorCheck == 4 then -- Door has been checked four times
            player:messageSpecial(ID.text.FIFTH_CHECK)
            player:setCharVar('SSG_MythrilDoor', 5)
        elseif mythrilDoorCheck == 5 then -- Door has been checked five times
            player:messageSpecial(ID.text.MYTHRIL_CHECK)
            player:setCharVar('SSG_MythrilDoor', 6)
        elseif mythrilDoorCheck == 6 or mythrilDoorCheck == 7 then -- Door has been checked six or more times
            player:messageSpecial(ID.text.COMPLETED_CHECK, xi.item.MYTHRIL_BEASTCOIN)
            player:setCharVar('SSG_MythrilDoor', 7)
        end
    elseif xPos < 40 and zPos < 24 then
        return -1 -- Open the door if coming from the 'inside'
    end
end

return entity
