-----------------------------------
-- Area: Lebros Cavern (Wamoura Farm Raid)
--  Mob: Ranch Wamouracampa
-----------------------------------

function onMobEngaged(mob, target)

end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
