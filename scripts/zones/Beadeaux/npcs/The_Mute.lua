-----------------------------------
-- Area: Beadeaux
--  NPC: ???
-- !pos -166.230 -1 -73.685 147
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local duration = math.random(600, 900)

    npc:entityAnimationPacket("sils", player)
    player:addStatusEffect(xi.effect.SILENCE, 0, 0, duration)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
