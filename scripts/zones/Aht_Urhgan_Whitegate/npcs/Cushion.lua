-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Cushion
-- Trust Gessho
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
if player:getCurrentMission(TOAU) >= xi.mission.id.toau.PASSING_GLORY then
        player:addSpell(918)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
