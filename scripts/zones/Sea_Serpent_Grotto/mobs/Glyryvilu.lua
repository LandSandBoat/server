-----------------------------------
-- Area: Sea Serpent Grotto
-- Mob: Glyryvilu
-- Note: Popped by qm5
-- !pos 135 -9 220
-- Involved in Quest: An Undying Pledge
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar("anUndyingPledgeCS") == 2 then
        player:setCharVar("anUndyingPledgeNM_killed", 1)
    end
end

return entity
