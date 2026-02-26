-----------------------------------
-- Area: Port Bastok
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
    print(string.format('DEUBG: csid: %d, option: %d', csid, option))
    if csid == 9601 then
        if xi.shop.curioVendorMoogleStock[option] then
            xi.shop.curioVendorMoogle(player, xi.shop.curioVendorMoogleStock[option])
        end
    end
end

return entity
