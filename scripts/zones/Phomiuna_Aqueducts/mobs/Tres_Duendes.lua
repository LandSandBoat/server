-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Tres Duendes
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("shiftTime", os.time() + 60)
end

entity.onMobFight = function(mob, target)
    local shiftTime = mob:getLocalVar("shiftTime")
    local form = mob:getAnimationSub()
    if os.time() > shiftTime and mob:canUseAbilities() then
        mob:setLocalVar("shiftTime", os.time() + 30)
        local whichForm = math.random(1,2)
        if form == 1 and whichForm == 1 then -- Vertical Bats (100% Triple Attack)
            mob:setDamage(40)
            mob:setMod(xi.mod.DELAY, 0)
            mob:setAnimationSub(3)
            mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1196)
        elseif form == 1 and whichForm == 2 then -- Horizontal Bats (Slow attacks but very strong hits)
            mob:setDamage(80)
            mob:setMod(xi.mod.DELAY, -2400)
            mob:setAnimationSub(2)
            mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 1197)
        elseif form > 1 then -- Normal Bats
            mob:setDamage(40)
            mob:setMod(xi.mod.DELAY, 0)
            mob:setAnimationSub(1)
            mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 47)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local ph = mob:getID() - 1
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(924)
    mob:setLocalVar("cooldown", os.time() + math.random(75600, 86400))
end

return entity
