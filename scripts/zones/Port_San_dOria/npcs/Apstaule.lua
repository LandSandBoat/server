-----------------------------------
-- Area: Port San d'Oria
--  NPC: Apstaule
-- Not used cutscenes: 541
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.item.PARCEL_FOR_THE_AUCTION_HOUSE, 1) and
        trade:getItemCount() == 1
    then
        local theBrugaireConsortium = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)
        if theBrugaireConsortium == 1 then
            player:tradeComplete()
            player:startEvent(540)
            player:setCharVar('TheBrugaireConsortium-Parcels', 21)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(542)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
