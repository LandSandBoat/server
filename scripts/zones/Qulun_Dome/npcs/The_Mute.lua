-----------------------------------
-- Area: Qulun Dome
--  NPC: The Mute
-- !zone 148
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local duration = math.random(600, 900)

    if (player:hasStatusEffect(tpz.effect.SILENCE) == false) then
        player:addStatusEffect(tpz.effect.SILENCE, 0, 0, duration)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
