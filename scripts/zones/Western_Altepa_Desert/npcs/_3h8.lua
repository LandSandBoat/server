-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h8 (Sapphire Column)
-- Notes: Mechanism for Altepa Gate
-- !pos -499 10 224 125
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
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

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
