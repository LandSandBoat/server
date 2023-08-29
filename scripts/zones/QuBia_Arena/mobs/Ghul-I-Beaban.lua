-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ghul-I-Beaban
-- BCNM: Undying Promise
-----------------------------------
local entity = {}

local function reraiseGhul(mob, reraises, target)
    mob:setLocalVar('RERAISES', reraises)
    mob:setMod(xi.mod.ATT, 25 * reraises)
    mob:setHP(mob:getMaxHP() * (1 - (0.10 * reraises)))
    mob:resetAI()
    mob:stun(3000)
    if target then
        mob:updateClaim(target)
    end
end

entity.onMobInitialize = function(GhulIBeabanMob)
    GhulIBeabanMob:addListener('DEATH', 'GHUL_DEATH', function(mob)
        local mobId = mob:getID()
        local reraises = mob:getLocalVar('RERAISES') + 1
        local target = mob:getTarget()

        -- spawn second form (BLM)
        if reraises == 3 then
            mob:timer(9000, function(mobArg)
                mobArg:setStatus(xi.status.DISAPPEAR)
                local finalMobId = mobId + 1
                local finalMob = GetMobByID(finalMobId)
                finalMob:setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos())
                finalMob:spawn()
                reraiseGhul(finalMob, 3, target)
            end)
        -- reraise up to 4 times
        elseif reraises < 5 then
            mob:timer(9000, function(mobArg)
                reraiseGhul(mobArg, reraises, target)
            end)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar('RERAISES') == 4 then
        mob:getBattlefield():setLocalVar('lootSpawned', 0)
    end
end

return entity
