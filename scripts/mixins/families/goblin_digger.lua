-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- a digger digs during a rest every 10 to 30 minutes and walks on 5 s later
local digMinutesMin = 10
local digMinutesMax = 30
local digSeconds    = 5

local function armDig(mob)
    mob:setLocalVar('[digger]nextDig', GetSystemTime() + math.randomInt(digMinutesMin, digMinutesMax) * 60)
end

g_mixins.families.goblin_digger = function(diggerMob)
    diggerMob:addListener('ROAM_TICK', 'GOBLIN_DIGGER_ROAM_TICK', function(mob)
        local nextDig = mob:getLocalVar('[digger]nextDig')
        if nextDig == 0 then
            armDig(mob)
            return
        end

        if mob:isFollowingPath() or GetSystemTime() < nextDig then
            return
        end

        -- TODO: This is where you plug Chocobo Digging code
        mob:entityAnimationPacket('horu')
        mob:wait(digSeconds * 1000)
        armDig(mob)
    end)
end

return g_mixins.families.goblin_digger
