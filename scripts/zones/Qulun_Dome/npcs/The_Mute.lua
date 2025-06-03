-----------------------------------
-- Area: Qulun Dome
--  NPC: The Mute
-- !zone 148
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local duration = math.random(600, 900)

    if not player:hasStatusEffect(xi.effect.SILENCE) then
        player:addStatusEffect(xi.effect.SILENCE, 0, 0, duration)
    end
end

return entity
