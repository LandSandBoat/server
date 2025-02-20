-----------------------------------
-- Area: Port San d'Oria
--  NPC: Curio Vendor Moogle
--  Shop NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.RHAPSODY_IN_WHITE) then
        player:startEvent(9600)
    else
        player:startEvent(9601)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 9601 then
        if option >= 1 and option <= 6 then
            local stock = xi.shop.curioVendorMoogleStock[option]
            xi.shop.curioVendorMoogle(player, stock)
        end
    end
end

return entity
