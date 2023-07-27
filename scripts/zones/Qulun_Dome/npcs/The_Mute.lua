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

    if not player:hasStatusEffect(xi.effect.SILENCE) then
        player:addStatusEffect(xi.effect.SILENCE, 0, 0, duration)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
