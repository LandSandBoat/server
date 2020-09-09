-----------------------------------
-- Area: Appolyon
-- NPC:  Radiant_Aureole
-- !pos
-----------------------------------
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Apollyon/IDs")

function onTrade(player, npc, trade)
    if player:hasKeyItem(tpz.ki.COSMOCLEANSE) and player:hasKeyItem(tpz.ki.RED_CARD) then
        player:setCharVar("ApollyonEntrance", 0)
        TradeBCNM(player, npc, trade)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.COSMOCLEANSE) and player:hasKeyItem(tpz.ki.RED_CARD) then
        player:setCharVar("ApollyonEntrance", 0)
        EventTriggerBCNM(player, npc)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

function onEventUpdate(player, csid, option, extras)
    if EventUpdateBCNM(player, csid, option, extras) then
        for _, member in pairs(player:getAlliance()) do
            if member:getZoneID() == player:getZoneID() and not member:hasStatusEffect(tpz.effect.BATTLEFIELD) and not member:getBattlefield() then
                member:messageSpecial(ID.text.HUM)
            end
        end
    end
end

function onEventFinish(player, csid, option)
    if not EventFinishBCNM(player, csid, option) then
        player:setCharVar("ApollyonEntrance", 0)
    end
end