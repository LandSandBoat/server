-----------------------------------
-- Area: Windurst Walls
--  Door: Priming Gate
--  Involved in quest: Toraimarai Turmoil
-- TODO: There is an edge case where if the player is on the lip of the door on the inside they will get the CS to enter the canal.
--       Due to the placement of the door, could not map an exception for the lip, without causing issues with the entry CS.
-----------------------------------
local ID = zones[xi.zone.WINDURST_WALLS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local y = player:getYPos()

    if y == -2.25 then
        player:startEvent(395)
    else
        if player:hasKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) then
                player:startEvent(401)
        else
            player:messageSpecial(ID.text.DOORS_SEALED_SHUT)
        end
    end
end

return entity
