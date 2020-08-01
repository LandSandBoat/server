-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h8 (Sapphire Column)
-- Notes: Mechanism for Altepa Gate
-- !pos -499 10 224 125
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if npc:getAnimation() ~= tpz.anim.OPEN_DOOR then
        npc:setAnimation(tpz.anim.OPEN_DOOR)
        GetNPCByID(npc:getID() - 4):setAnimation(tpz.anim.OPEN_DOOR)
    else
        player:messageSpecial(ID.text.DOES_NOT_RESPOND)
    end

    if
        GetNPCByID(ID.npc.ALTEPA_GATE + 5):getAnimation() == tpz.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 6):getAnimation() == tpz.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 7):getAnimation() == tpz.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 8):getAnimation() == tpz.anim.OPEN_DOOR
    then
        local openTime = math.random(15, 30) * 60
        for i = ID.npc.ALTEPA_GATE, ID.npc.ALTEPA_GATE + 8 do
            GetNPCByID(i):openDoor(openTime)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
