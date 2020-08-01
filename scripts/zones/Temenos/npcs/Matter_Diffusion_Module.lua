-----------------------------------
-- Area: temenos
-- NPC:  Matter diffusion module
-- !pos
-----------------------------------
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Temenos/IDs")

function onTrade(player, npc, trade)
    if player:hasKeyItem(tpz.ki.COSMOCLEANSE) and player:hasKeyItem(tpz.ki.WHITE_CARD) then
        TradeBCNM(player, npc, trade)
    else
        player:messageSpecial(ID.text.NO_KEY)
    end
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.COSMOCLEANSE) and player:hasKeyItem(tpz.ki.WHITE_CARD) then
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
    EventFinishBCNM(player, csid, option)
end
