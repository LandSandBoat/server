-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ajido-Marujido
-- Ally during Windurst Mission 9-2
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------
---@type TMobEntity
local entity = {}

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
end

entity.onMobRoam = function(mob)
    local wait = mob:getLocalVar('wait')
    if wait > 40 and not mob:getTarget() then
        local battlefieldArea = mob:getBattlefield():getArea()
        local mobOffset       = ID.mob.ACE_OF_CUPS + (battlefieldArea - 1) * 6 + 4

        local livingMobs = {}
        for mobId = mobOffset, mobOffset + 1 do
            local target = GetMobByID(mobId)

            if
                target and
                target:isSpawned() and
                not target:isDead()
            then
                table.insert(livingMobs, target)
            end
        end

        local newTarget = livingMobs[math.random(1, #livingMobs)]
        mob:addEnmity(newTarget, 0, 1)
        mob:updateEnmity(newTarget)
    else
        mob:setLocalVar('wait', wait + 3)
    end
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
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
    local players = mob:getBattlefield():getPlayers()
    for _, playerObj in pairs(players) do
        playerObj:messageSpecial(ID.text.UNABLE_TO_PROTECT)
    end
end

return entity
