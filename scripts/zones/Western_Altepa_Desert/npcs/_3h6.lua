-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h6 (Topaz Column)
-- Notes: Mechanism for Altepa Gate
-- !pos -260 10 -344 125
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() ~= xi.anim.OPEN_DOOR then
        npc:setAnimation(xi.anim.OPEN_DOOR)
        GetNPCByID(npc:getID() - 4):setAnimation(xi.anim.OPEN_DOOR)
    else
        player:messageSpecial(ID.text.DOES_NOT_RESPOND)
    end

    if
        GetNPCByID(ID.npc.ALTEPA_GATE + 5):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 6):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 7):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 8):getAnimation() == xi.anim.OPEN_DOOR
    then
        local openTime = math.random(15, 30) * 60
        for i = ID.npc.ALTEPA_GATE, ID.npc.ALTEPA_GATE + 8 do
            GetNPCByID(i):openDoor(openTime)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
