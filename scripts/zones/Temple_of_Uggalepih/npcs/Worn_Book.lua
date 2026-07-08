-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Worn Book
-- Getting "Old Rusty Key (keyitem)"
-- !pos 59 0 19 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.OLD_RUSTY_KEY) or
        player:hasKeyItem(xi.ki.PAINTBRUSH_OF_SOULS)
    then
        player:messageSpecial(ID.text.NO_REASON_TO_INVESTIGATE)
    else
        local offset = npc:getID() - ID.npc.BOOK_OFFSET
        player:startEvent(61 + offset)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local book = player:getCharVar('paintbrushOfSouls_book')

    if
        csid == 61 and
        option == 1 and
        (book == 0 or book == 2 or book == 4 or book == 6)
    then
        player:setCharVar('paintbrushOfSouls_book', book + 1)
    elseif
        csid == 62 and
        option == 1 and
        (book == 0 or book == 1 or book == 4 or book == 5)
    then
        player:setCharVar('paintbrushOfSouls_book', book + 2)
    elseif
        csid == 63 and
        option == 1 and
        (book == 0 or book == 1 or book == 2 or book == 3)
    then
        player:setCharVar('paintbrushOfSouls_book', book + 4)
    end

    if player:getCharVar('paintbrushOfSouls_book') == 7 then
        player:messageSpecial(ID.text.FALLS_FROM_THE_BOOK, xi.ki.OLD_RUSTY_KEY)
        npcUtil.giveKeyItem(player, xi.ki.OLD_RUSTY_KEY)
        player:setCharVar('paintbrushOfSouls_book', 0)
    end
end

return entity
