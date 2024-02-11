-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ajido-Marujido
-- Ally during Windurst Mission 9-2
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------
local entity = {}

local function ajidoSelectTarget(mobArg)
    -- pick a random living target from the two enemies
    local inst       = mobArg:getBattlefield():getArea()
    local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))
    local livingMobs = {}

    for i = 4, 5 do
        local mobTarget = GetMobByID(instOffset + i)
        if not mobTarget:isDead() then
            table.insert(livingMobs, mobTarget)
        end
    end

    local target = livingMobs[math.random(1, #livingMobs)]
    if not target:isDead() then
        mobArg:addEnmity(target, 0, 1)
    end

    mobArg:engage(target:getID())
end

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REFRESH, 1)
    mob:setMobMod(xi.mobMod.TELEPORT_CD, 30)
end

entity.onMobSpawn = function(ajidoMob)
    ajidoMob:addListener('MAGIC_START', 'MAGIC_MSG', function(mob, spell, action)
        -- Burst
        if spell:getID() == 212 then
            mob:showText(mob, ID.text.PLAY_TIME_IS_OVER)
        -- Flood
        elseif spell:getID() == 214 then
            mob:showText(mob, ID.text.YOU_SHOULD_BE_THANKFUL)
        end
    end)

    -- TODO: This doesn't work, but the logic is here.
    ajidoMob:timer(40000, function(mobArg)
        ajidoSelectTarget(mobArg)
    end)
end

entity.onMobRoam = function(mob)
end

entity.onMobEngage = function(mob, target)
    mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 0)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 50 and mob:getLocalVar('saidMessage') == 0 then
        mob:showText(mob, ID.text.DONT_GIVE_UP)
        mob:setLocalVar('saidMessage', 1)
    end

    if target:isEngaged() then
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
    end
end

entity.onMobDisengage = function(mob)
    -- If the engaged enemy is defeated, select a new available
    -- target from living enemies.
    ajidoSelectTarget(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
    local players = mob:getBattlefield():getPlayers()
    for _, playerObj in pairs(players) do
        playerObj:messageSpecial(ID.text.UNABLE_TO_PROTECT)
    end
end

return entity
