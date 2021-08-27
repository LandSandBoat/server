-----------------------------------
-- Matrimonial Coffer NPCs
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
xi = xi or {}
xi.matrimonialcoffer = xi.matrimonialcoffer or {}

function xi.matrimonialcoffer.startEvent(player)
    local playerGender = player:getGender()
    if playerGender == 1 then
        player:startEvent(2000, playerGender, 200000, xi.items.MATRIMONY_BAND, 100000, player:getGil())   -- Male Dialog
    else
        player:startEvent(2000, playerGender, 400000, xi.items.MATRIMONY_RING, 80000, player:getGil())    -- Female Dialog
    end
end

function xi.matrimonialcoffer.finishEvent(player, csid, option)
    local zone = player:getZoneID()
    local ID = zones[zone]
    local playerGender = player:getGender()
    if playerGender == 1 and csid == 2000 then
        if option == 1 and player:getGil() >= 200000 and
        (not player:hasItem(xi.items.BENEDIGHT_HOSE) or not player:hasItem(xi.items.BENEDIGHT_COAT)) then
            if npcUtil.giveItem(player, {xi.items.BENEDIGHT_HOSE, xi.items.BENEDIGHT_COAT}) then
                player:delGil(200000)
            end
        elseif option == 1 and player:getGil() < 200000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        elseif option == 2 and player:getGil() >= 100000 then
            if npcUtil.giveItem(player, {xi.items.MATRIMONY_BAND}) then
                player:delGil(100000)
            end
        elseif option == 2 and player:getGil() < 100000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        end
    elseif playerGender == 0 and csid == 2000 then
        if option == 1 and player:getGil() >= 400000 and (not player:hasItem(xi.items.BRIDAL_CORSAGE) or
            not player:hasItem(xi.items.WEDDING_DRESS) or not player:hasItem(xi.items.WEDDING_HOSE) or not player:hasItem(xi.items.WEDDING_BOOTS)) then
            if npcUtil.giveItem(player, {xi.items.BRIDAL_CORSAGE, xi.items.WEDDING_DRESS, xi.items.WEDDING_HOSE, xi.items.WEDDING_BOOTS}) then
                player:delGil(400000)
            end
        elseif option == 1 and player:getGil() < 400000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        elseif option == 2 and player:getGil() >= 80000 then
            if npcUtil.giveItem(player, {xi.items.MATRIMONY_RING}) then
                player:delGil(80000)
            end
        elseif option == 2 and player:getGil() < 80000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        end
    end
end
