-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--   NM: Ashu Talif Captain
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
-----------------------------------
local entity = {}

local captainEngageSequence = function(mob)
    local jumped = mob:getLocalVar('jump')
    local ready = mob:getLocalVar('ready')

    -- Becomes ready when the Crew is engaged. Jump down!
    if ready == 1 and jumped == 0 then
        mob:setLocalVar('jump', 1)
        mob:showText(mob, ID.text.OVERPOWERED_CREW)
        mob:hideName(true)
        mob:entityAnimationPacket('jmp0')
        mob:timer(2000, function(m)
            m:setPos(0, -22, 13, 192)
            m:entityAnimationPacket('jmp1')
            m:showText(mob, ID.text.TEST_YOUR_BLADES)
            m:timer(2000, function(mAnimation)
                mAnimation:hideName(false)
                mAnimation:setUntargetable(false)
            end)
        end)
    end
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
end

entity.onMobEngaged = function(mob, target)
    captainEngageSequence(mob)
end

entity.onMobRoam = function(mob)
    -- failsafe in case of party wipe/reraise
    captainEngageSequence(mob)
end

entity.onMobFight = function(mob, target)
    -- The captain gives up at <= 20% HP. Everyone disengages
    local instance = mob:getInstance()
    if mob:getHPP() <= 20 and not instance:completed() then
        instance:complete()
    end

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(m, skillID)
        -- Vulcan Shot
        if skillID == 254 then
            m:showText(m, ID.text.FOR_EPHRAMAD)
            m:timer(3000, function(mArg)
                mArg:showText(mArg, ID.text.TROUBLESOME_SQUABS)
            end)
        -- Circle Blade
        elseif skillID == 938 then
            m:showText(m, ID.text.FOR_THE_BLACK_COFFIN)
        end
    end)
end

entity.onMobDisengage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
