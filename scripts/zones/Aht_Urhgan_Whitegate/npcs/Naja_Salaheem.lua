-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Naja Salaheem
-- !pos 22.700 -8.804 -45.591 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.IMPERIAL_CORONATION then
        player:startEvent(3150, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.THE_EMPRESS_CROWNED then
        player:startEvent(3144, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.ETERNAL_MERCENARY then
        player:startEvent(3154, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(3003, 1, 0, 0, 0, 0, 0, 0, 1, 0) -- go back to work
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3144 then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_EMPRESS_CROWNED)
        player:addItem(xi.item.GLORY_CROWN)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.GLORY_CROWN)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY)
    end
end

return entity
