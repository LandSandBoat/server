-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Miasma
-----------------------------------
local entity = {}

entity.onTimeTrigger = function(npc, triggerID)
    local timer = npc:getLocalVar("timer")

    if npc:getAnimation() == 8 and os.time() >= timer then
        npc:setAnimation(9)
        npc:setLocalVar("timer", os.time() + math.random(30,40))
    elseif npc:getAnimation() == 9 and os.time() >= timer then
        npc:setAnimation(8)
        npc:setLocalVar("timer", os.time() + math.random(14,16))
    end
end

return entity
