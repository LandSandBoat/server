-----------------------------------
-- Area: Nashmau
--  NPC: Awaheen
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade:                              Receive:
    -- 1 x Imperial Gold Piece (2187)       5 x Imperial Mythril Piece(2186)
    -- 1 x Imperial Mythril Piece(2186)        2 x Imperial Silver Piece(2185)
    -- 1 x Imperial Silver Piece (2185)       5 x Imperial Bronze Piece(2184)
    local nbr = 0
    local reward = 0
    if trade:getItemCount() == 1 then
        if trade:hasItemQty(xi.item.IMPERIAL_GOLD_PIECE, 1) then
            nbr = 5
            reward = xi.item.IMPERIAL_MYTHRIL_PIECE
        elseif trade:hasItemQty(xi.item.IMPERIAL_MYTHRIL_PIECE, 1) then
            nbr = 2
            reward = xi.item.IMPERIAL_SILVER_PIECE
        elseif trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, 1) then
            nbr = 5
            reward = xi.item.IMPERIAL_BRONZE_PIECE
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

return entity
