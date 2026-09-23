-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Abquhbah
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- 3152 on Nashmiera's Plea (oncePerZone)

    player:startEvent(255)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 255 then
        if option == 1 then
            player:updateEvent(xi.besieged.getMercenaryRank(player), 1)
        elseif option == 99 then
            player:updateEvent(1, 1)
        elseif option == 2 then
            local promotion = player:getCharVar('AssaultPromotion')
            local stage = 0

            if promotion <= 7 then
                stage = 1
            elseif promotion <= 11 then
                stage = 2
            elseif promotion <= 18 then
                stage = 3
            elseif promotion <= 24 then
                stage = 4
            else
                stage = 5
            end

            player:updateEvent(stage, 1)
        end
    end
end

return entity
