-----------------------------------
-- Area: Nashmau
--  NPC: Awaheen
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade:                              Receive:
    -- 1 x Imperial Gold Piece (2187)       5 x Imperial Mythril Piece(2186)
    -- 1 x Imperial Mythril Piece(2186)        2 x Imperial Silver Piece(2185)
    -- 1 x Imperial Silver Piece (2185)       5 x Imperial Bronze Piece(2184)
    local nbr = 0
    local reward = 0
    if trade:getItemCount() == 1 then
        if trade:hasItemQty(2187, 1) then
            nbr = 5
            reward = 2186
        elseif trade:hasItemQty(2186, 1) then
            nbr = 2
            reward = 2185
        elseif trade:hasItemQty(2185, 1) then
            nbr = 5
            reward = 2184
        end
    end

    if reward > 0 then
        if player:getFreeSlotsCount() >= 1 then
            player:tradeComplete()
            player:addItem(reward, nbr)
            for boucle = 1, nbr, 1 do
                player:messageSpecial(ID.text.ITEM_OBTAINED, reward)
            end
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(240)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
