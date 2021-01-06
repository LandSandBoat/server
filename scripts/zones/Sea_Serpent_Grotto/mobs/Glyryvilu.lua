-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Glyryvilu
-- Note: Popped by qm1
-- !pos 135x -9y 220z
-- Involved in Quest: An Undying Pledge
-----------------------------------


function onMobDeath(mob, player, isKiller)
    if player:getCharVar("anUndyingPledgeCS") == 2 then
        player:setCharVar("anUndyingPledgeNM_killed", 1)
    end
end
