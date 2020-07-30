-----------------------------------
-- Area: Port San d'Oria
--  NPC: Apstaule
-- Not used cutscenes: 541
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    -- "Flyers for Regine" conditional script
    local count = trade:getItemCount()
    local MagicFlyer    = trade:hasItemQty(532, 1)
    local AuctionParcel = trade:hasItemQty(594, 1)

    if (MagicFlyer == true and count == 1) then
        local FlyerForRegine = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)
        if (FlyerForRegine == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    elseif (AuctionParcel == true and count == 1) then
        local TheBrugaireConsortium = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)
        if (TheBrugaireConsortium == 1) then
            player:tradeComplete()
            player:startEvent(540)
            player:setCharVar("TheBrugaireConsortium-Parcels", 21)
        end
    end

end

function onTrigger(player, npc)
    player:startEvent(542)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
