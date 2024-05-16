-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ghul-I-Beaban
-- BCNM: Undying Promise
-----------------------------------
local entity = {}

local function reraiseGhul(mob, numReraises, target)
    mob:setLocalVar('numReraises', numReraises)
    mob:setMod(xi.mod.ATT, 25 * numReraises)
    mob:setHP(mob:getMaxHP() * (1 - (0.10 * numReraises)))
    mob:resetAI()
    mob:stun(3000)
    if target then
        mob:updateClaim(target)
    end
end

entity.onMobInitialize = function(GhulIBeabanMob)
    GhulIBeabanMob:addListener('DEATH', 'GHUL_DEATH', function(mob)
        local numReraises = mob:getLocalVar('numReraises') + 1
        local target      = mob:getTarget()

        if numReraises <= 2 or numReraises == 4 then
            mob:timer(9000, function(mobArg)
                reraiseGhul(mobArg, numReraises, target)
            end)
        elseif numReraises == 3 then
            mob:timer(9000, function(mobArg)
                mobArg:setStatus(xi.status.DISAPPEAR)
                local blmMobId  = mobArg:getID() + 1
                local blmMobObj = GetMobByID(blmMobId)
                blmMobObj:setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos(), mob:getRotPos())
                blmMobObj:spawn()
                reraiseGhul(blmMobObj, 3, target)
            end)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
