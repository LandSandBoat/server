-----------------------------------
-- Area: Crawlers Nest [S]
--  NPC: Kalsu-Kalasu
-- !pos 304.768 -33.519 -19.168 171
-- Notes: Gives Green Letter required to start "Snake on the plains"
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCampaignAllegiance() > 0 then
        if player:getCampaignAllegiance() == 2 then
            player:startEvent(3)
        else
            -- message for other nations missing
            player:startEvent(3)
        end
    elseif player:hasKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER) then
        player:startEvent(2)
    elseif not player:hasKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER) then
        player:startEvent(1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 and option == 0 then
        npcUtil.giveKeyItem(player, xi.ki.GREEN_RECOMMENDATION_LETTER)
    end
end

return entity
