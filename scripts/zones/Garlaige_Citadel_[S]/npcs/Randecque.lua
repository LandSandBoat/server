-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Randecque
-- !pos 61 -6 137 164
-- Notes: Gives Red Letter required to start "Steamed Rams"
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCampaignAllegiance() > 0 then
        if player:getCampaignAllegiance() == 2 then
            player:startEvent(3)
        else
            -- message for other nations missing
            player:startEvent(3)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
