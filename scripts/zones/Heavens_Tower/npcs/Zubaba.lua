-----------------------------------
-- Area: Heavens Tower
--  NPC: Zubaba
-- Involved in Mission 3-2
-- !pos 15 -27 18 242
-----------------------------------
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.STAR_CRESTED_SUMMONS_1) then
        player:startEvent(157)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
