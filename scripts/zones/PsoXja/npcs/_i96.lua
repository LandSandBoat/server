-----------------------------------
-- Area: Pso'Xja
--  NPC: _i96 (Stone Gate)
-- Notes: Red Bracelet Door
-- !pos -310.000 -1.925 -238.399 9
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local zPos = player:getZPos()

    if zPos >= -238 then
        if player:hasKeyItem(xi.ki.GREEN_BRACELET) then -- Green Bracelet
            player:startEvent(62)
        else
            player:messageSpecial(ID.text.ARCH_GLOW_GREEN)
        end
    elseif zPos <= -239 then
        player:messageSpecial(ID.text.CANNOT_OPEN_SIDE)
    end
end

return entity
