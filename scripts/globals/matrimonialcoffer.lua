-----------------------------------
-- Matrimonial Coffer NPCs
-----------------------------------
require("scripts/globals/npc_util")

tpz = tpz or {}
 xi.matrimonialcoffer = xi.matrimonialcoffer or {}

function xi.matrimonialcoffer.startEvent(player)
    local playerGender = player:getGender()
    if playerGender == 1 then
        player:startEvent(2000, playerGender, 200000, 15848, 100000, player:getGil())   -- Male Dialog
    else
        player:startEvent(2000, playerGender, 400000, 15847, 80000, player:getGil())    -- Female Dialog
    end
end

function xi.matrimonialcoffer.finishEvent(player, csid, option)
    local zone = player:getZoneID()
    local ID = zones[zone]
    local playerGender = player:getGender()
    if playerGender == 1 and csid == 2000 then
        if option == 1 and player:getGil() >= 200000 and
        (not player:hasItem(16364) or not player:hasItem(11309)) then
            if npcUtil.giveItem(player, {16364, 11309}) then
                player:delGil(200000)
            end
        elseif option == 1 and player:getGil() < 200000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        elseif option == 2 and player:getGil() >= 100000 then
            if npcUtil.giveItem(player, {15848}) then
                player:delGil(100000)
            end
        elseif option == 2 and player:getGil() < 100000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        end
    elseif playerGender == 0 and csid == 2000 then
        if option == 1 and player:getGil() >= 400000 and (not player:hasItem(13933) or
            not player:hasItem(14386) or not player:hasItem(14251) or not player:hasItem(14126)) then
            if npcUtil.giveItem(player, {13933, 14386, 14251, 14126}) then
                player:delGil(400000)
            end
        elseif option == 1 and player:getGil() < 400000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        elseif option == 2 and player:getGil() >= 80000 then
            if npcUtil.giveItem(player, {15847}) then
                player:delGil(80000)
            end
        elseif option == 2 and player:getGil() < 80000 then
            player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
        end
    end
end
