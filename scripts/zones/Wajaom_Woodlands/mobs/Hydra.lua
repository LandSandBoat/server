-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar('headgrow')
    local broken = mob:getAnimationSub()

    if headgrow < battletime and broken > 4 then
        mob:setAnimationSub(broken - 1)
        mob:setLocalVar('headgrow', battletime + 300)
    end
end

entity.onCriticalHit = function(mob)
    local rand = math.random()
    local battletime = mob:getBattleTime()
    local headbreak = mob:getLocalVar('headbreak')
    local broken = mob:getAnimationSub()

    if rand <= 0.15 and battletime >= headbreak and broken < 6 then
        mob:setAnimationSub(broken + 1)
        mob:setLocalVar('headgrow', battletime + math.random(120, 240))
        mob:setLocalVar('headbreak', battletime + 300)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.HYDRA_HEADHUNTER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1 hour windows
end

return entity
