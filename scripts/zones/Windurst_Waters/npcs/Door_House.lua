-----------------------------------
-- Area: Windurst Waters
--  NPC: Door_House
-- (Corsair's Gants) !pos -200 -4 -111 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local npcID = npc:getID()
    if npcID == ID.npc.LELEROON_GREEN_DOOR then
        local letterGreen = player:getCharVar('LeleroonsLetterGreen')

        -- gold thread, karakul leather, red grass cloth, wamoura silk
        if
            letterGreen == 2 and
            trade:getItemCount() == 4 and
            trade:hasItemQty(xi.item.SPOOL_OF_GOLD_THREAD, 1) and
            trade:hasItemQty(xi.item.SQUARE_OF_KARAKUL_LEATHER, 1) and
            trade:hasItemQty(xi.item.SQUARE_OF_RED_GRASS_CLOTH, 1) and
            trade:hasItemQty(xi.item.SPOOL_OF_WAMOURA_SILK, 1)
        then
            player:startEvent(943) -- accepts materials, now bring me 4 imperial mythril pieces

        -- 4 imperial mythril pieces
        elseif
            letterGreen == 3 and
            trade:getItemCount() == 4 and
            trade:hasItemQty(xi.item.IMPERIAL_MYTHRIL_PIECE, 4)
        then
            player:startEvent(946) -- accepts mythril pieces, now wait for next vana'diel day
        end
    end
end

entity.onTrigger = function(player, npc)
    local npcID = npc:getID()
    if npcID == ID.npc.LELEROON_GREEN_DOOR then
        local letterGreen = player:getCharVar('LeleroonsLetterGreen')
        if player:hasKeyItem(xi.ki.LELEROONS_LETTER_GREEN) then
            player:startEvent(941) -- accept letter, now bring me four items
        elseif letterGreen == 2 then
            player:startEvent(942) -- i'm waiting for four items
        elseif letterGreen == 3 then
            player:startEvent(954) -- i'm waiting for 4 imperial mythril pieces
        elseif letterGreen == 4 then
            if VanadielUniqueDay() > player:getCharVar('corAfSubmitDay') then
                player:startEvent(944) -- here's your cor gants
            else
                player:startEvent(945) -- patience. need to wait for vana'diel day
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 941 then
        player:setCharVar('LeleroonsLetterGreen', 2)
        player:delKeyItem(xi.ki.LELEROONS_LETTER_GREEN)
    elseif csid == 943 then
        player:tradeComplete()
        player:setCharVar('LeleroonsLetterGreen', 3)
    elseif csid == 946 then
        player:tradeComplete()
        player:setCharVar('LeleroonsLetterGreen', 4)
        player:setCharVar('corAfSubmitDay', VanadielUniqueDay())
    elseif csid == 944 then
        player:setCharVar('LeleroonsLetterGreen', 5)
        player:addItem(xi.item.CORSAIRS_GANTS) -- corsair's gants
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CORSAIRS_GANTS)
    end
end

return entity
