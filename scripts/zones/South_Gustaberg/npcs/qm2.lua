-----------------------------------
-- Area: South Gustaberg
--  NPC: qm2 (???)
-- Involved in Quest: Smoke on the Mountain
-- !pos 461.841 -21.515 -580.105 107
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if not npcUtil.tradeMatches(trade, { { xi.item.SLICE_OF_GIANT_SHEEP_MEAT, 1 } }) then
        return
    end

    if player:getCharVar('SouthGustabergCampfire') ~= 0 then
        return player:messageSpecial(ID.text.MEAT_ALREADY_PUT, xi.item.SLICE_OF_GIANT_SHEEP_MEAT)
    end

    player:tradeComplete()

    -- The meat is done at the next Earth clock minute, not after a flat duration.
    -- 2023-09-12 capture: traded at :35, still cooking at :58, done at :02.
    player:setCharVar('SouthGustabergCampfire', (math.floor(GetSystemTime() / 60) + 1) * 60)

    return player:messageSpecial(ID.text.FIRE_PUT, xi.item.SLICE_OF_GIANT_SHEEP_MEAT)
end

entity.onTrigger = function(player, npc)
    local cookTimer = player:getCharVar('SouthGustabergCampfire')

    -- Retail emits this as speakerless npc text (flag unset, type 6), even while the fire looks out.
    if cookTimer == 0 then
        return player:messageText(npc, ID.text.FIRE_GOOD, false, 6)
    end

    if GetSystemTime() < cookTimer then
        return player:messageSpecial(ID.text.FIRE_LONGER, xi.item.SLICE_OF_GIANT_SHEEP_MEAT)
    end

    if player:getFreeSlotsCount() == 0 then
        return player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.GALKAN_SAUSAGE)
    end

    player:setCharVar('SouthGustabergCampfire', 0)
    npcUtil.giveItem(player, xi.item.GALKAN_SAUSAGE, { silent = true })

    return player:messageSpecial(ID.text.FIRE_TAKE, xi.item.GALKAN_SAUSAGE)
end

return entity
