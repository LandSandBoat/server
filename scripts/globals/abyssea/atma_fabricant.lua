-----------------------------------
-- Abyssea Atma Fabricant
-----------------------------------
require('scripts/globals/abyssea')
-----------------------------------
xi = xi or {}
xi.atmaFabricant = xi.atmaFabricant or {}

xi.atmaFabricant.onTrade = function(player, npc)
end

xi.atmaFabricant.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]

    if not player:hasStatusEffect(xi.effect.VISITANT) then
        player:messageSpecial(ID.text.NO_VISITANT_STATUS)
    else
        player:startEvent(2182)
    end
end

xi.atmaFabricant.onEventUpdate = function(player, csid, option, npc)
end

xi.atmaFabricant.onEventFinish = function(player, csid, option, npc)
end
