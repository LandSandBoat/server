-----------------------------------
-- Area: Bastok Mines
--  NPC: Door_House (Corsair's Bottes)
-- !pos 10 0 -16 234
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npc:getID() == ID.npc.LELEROON_BLUE_DOOR then
        local letterBlue = player:getCharVar('LeleroonsLetterBlue')

        if
            letterBlue == 2 and
            npcUtil.tradeHas(trade, { xi.item.MYTHRIL_SHEET, xi.item.SQUARE_OF_KARAKUL_LEATHER, xi.item.SQUARE_OF_LM_BUFFALO_LEATHER, xi.item.SQUARE_OF_WOLF_FELT }) -- mythril sheet, karakul leather, laminated buffalo leather, wolf felt
        then
            player:startEvent(521) -- accepts materials, now bring me 4 imperial mythril pieces

        elseif
            letterBlue == 3 and
            npcUtil.tradeHas(trade, { { xi.item.IMPERIAL_MYTHRIL_PIECE, 4 } }) -- 4 imperial mythril pieces
        then
            player:startEvent(524) -- accepts mythril pieces, now wait for next vana'diel day
        end
    end
end

entity.onTrigger = function(player, npc)
    if npc:getID() == ID.npc.LELEROON_BLUE_DOOR then
        local letterBlue = player:getCharVar('LeleroonsLetterBlue')

        if player:hasKeyItem(xi.ki.LELEROONS_LETTER_BLUE) then
            player:startEvent(519) -- accept letter, now bring me four items

        elseif letterBlue == 2 then
            player:startEvent(520) -- i'm waiting for four items

        elseif letterBlue == 3 then
            player:startEvent(535) -- i'm waiting for 4 imperial mythril pieces

        elseif letterBlue == 4 then
            if VanadielUniqueDay() > player:getCharVar('corAfSubmitDay') then
                player:startEvent(522) -- here's your cor bottes
            else
                player:startEvent(523) -- patience. need to wait for vana'diel day
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 519 then
        player:setCharVar('LeleroonsLetterBlue', 2)
        player:delKeyItem(xi.ki.LELEROONS_LETTER_BLUE)

    elseif csid == 521 then
        player:confirmTrade()
        player:setCharVar('LeleroonsLetterBlue', 3)

    elseif csid == 524 then
        player:confirmTrade()
        player:setCharVar('LeleroonsLetterBlue', 4)
        player:setCharVar('corAfSubmitDay', VanadielUniqueDay())

    elseif
        csid == 522 and
        npcUtil.giveItem(player, xi.item.CORSAIRS_BOTTES)
    then
        player:setCharVar('LeleroonsLetterBlue', 5)
    end
end

return entity
