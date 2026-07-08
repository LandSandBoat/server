-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ironbound Gate
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()

    if (xPos > -43 and xPos < -37) and (zPos < -53 and zPos > -59) then
        player:startEvent(131) -- To Waj. Woodlands
    else
        player:startEvent(130) -- To B. Thickets
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 131 and option == 1 then
        player:setPos(690, -18.5, 220, 128, 51)        --> Wajaom Woodlands, at northeastern tower
    elseif csid == 130 and option == 1 then
        player:setPos(570.5, -10.5, 140, 128, 52)    --> Bhaflau Thickets, at southeastern tower
    end
end

return entity
