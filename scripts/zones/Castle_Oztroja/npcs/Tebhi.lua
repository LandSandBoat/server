-----------------------------------
-- Area: Castle Oztroja
--  NPC: Tebhi
-- !pos -136 24 -21 151
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:hasItemQty(13121, 1) and trade:getItemCount() == 1) then -- Trade Beast collar
        player:tradeComplete()
        -- Tebhi disappears for 15min -------------- NOT IMPLEMENTED
        player:setCharVar("scatIntoShadowCS", 2)
    end

end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
