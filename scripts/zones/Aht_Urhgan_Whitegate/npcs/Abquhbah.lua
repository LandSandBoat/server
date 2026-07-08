-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Abquhbah
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local promotion = player:getCharVar('AssaultPromotion')
    local rank = 0

    -- 3152 on Nashmiera's Plea (oncePerZone)

    if promotion <= 7 then
        rank = 1
    elseif promotion >= 8 and promotion <= 11 then
        rank = 2
    elseif promotion >= 12 and promotion <= 18 then
        rank = 3
    elseif promotion >= 19 then
        rank = 4
    end

    player:startEvent(255, rank)
end

return entity
