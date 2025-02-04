-----------------------------------
-- Area: Mhaura
--  NPC: Koh Lenbalalako
-- !pos -64.412 -17 29.213 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(xi.item.GOLD_EARRING, 1) and trade:getItemCount() == 1 then -- Trade gold earring (during Rng AF3 quest)
        local unbridledPassionCS = player:getCharVar('unbridledPassion')
        if unbridledPassionCS == 2 then
            player:startEvent(10011)
        end
    end
end

entity.onTrigger = function(player, npc)
    local fireAndBrimstoneCS = player:getCharVar('fireAndBrimstone')
    local unbridledPassionCS = player:getCharVar('unbridledPassion')

    -- during RNG af2
    if fireAndBrimstoneCS == 1 then
        player:startEvent(10007)

    -- during RNG af3
    elseif unbridledPassionCS == 1 then
        player:startEvent(10009, 0, 13360, xi.item.GOLD_EARRING)
    elseif unbridledPassionCS == 2 then
        player:startEvent(10010, 0, 0, xi.item.GOLD_EARRING)
    elseif unbridledPassionCS == 3 then
        player:startEvent(10012)

    else
        player:startEvent(10013)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10007 then
        player:startEvent(10032)
        player:setCharVar('fireAndBrimstone', 2)
    elseif csid == 10009 then
        player:setCharVar('unbridledPassion', 2)
    elseif csid == 10011 then
        npcUtil.giveKeyItem(player, xi.ki.KOHS_LETTER)
        player:tradeComplete()
        player:setCharVar('unbridledPassion', 3)
    end
end

return entity
