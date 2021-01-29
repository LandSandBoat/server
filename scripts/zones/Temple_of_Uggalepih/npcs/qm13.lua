-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (San dOria Mission 8-2)
-- !pos -68 -17 -153 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.LIGHTBRINGER and player:getMissionStatus(player:getNation()) == 4 then
        player:setMissionStatus(player:getNation(), 5)
        player:addKeyItem(xi.ki.PIECE_OF_A_BROKEN_KEY3)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PIECE_OF_A_BROKEN_KEY3)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
