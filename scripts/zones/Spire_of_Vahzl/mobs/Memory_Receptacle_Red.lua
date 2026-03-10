-----------------------------------
-- Area: Spire of Vahzl
--   NM: Memory Receptacle (Red)
-----------------------------------
local ID = zones[xi.zone.SPIRE_OF_VAHZL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.POISON)
end

entity.onMobSpawn = function(mob)
    mob:setModelId(1105)
    mob:setAutoAttackEnabled(false)
    mob:setAggressive(true)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING)
    mob:setMod(xi.mod.REGAIN, 550)

    -- Red receptacle starts with all damage immunities, which are removed when a respective shield receptacle dies
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGBREATH, -10000)

    -- Undo family wide SDT resistances
    mob:setMod(xi.mod.SLASH_SDT, 0)
    mob:setMod(xi.mod.PIERCE_SDT, 0)
    mob:setMod(xi.mod.HTH_SDT, 0)
    mob:setMod(xi.mod.IMPACT_SDT, 0)
end

entity.onMobEngage = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    mob:setLocalVar('drawInTimer', GetSystemTime() + 20)

    -- Select a random position for shield receptacles to spawn at
    local area      = mob:getBattlefield():getArea()
    local offset    = (area - 1) * 10
    local content   = xi.battlefield.contents[xi.battlefield.id.PULLING_THE_PLUG]
    local positions = content.positions
    local position  = math.random(1, #positions[area][1])

    battlefield:setLocalVar('position', position)
    battlefield:setLocalVar('moveTimer', GetSystemTime() + 30)

    for i = 0, 2 do
        local shieldMob = GetMobByID(ID.mob.MEMORY_RECEPTACLE_SHIELD + offset + i)
        if shieldMob then
            local pos = positions[area][i + 1][position]
            shieldMob:setSpawn(pos.x, pos.y, pos.z)
            shieldMob:spawn()
        end
    end
end

entity.onMobFight = function(mob, target)
    -- Every 20 seconds, memory receptacles draws in a random member in the battlefield
    local drawInTimer = mob:getLocalVar('drawInTimer')
    if GetSystemTime() > drawInTimer then
        local players = mob:getBattlefield():getPlayers()

        utils.drawIn(players[math.random(#players)], { position = mob:getPos() })

        mob:setLocalVar('drawInTimer', GetSystemTime() + 20)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    -- Every three moves, all shield receptacles simultaneously use Empty Seed
    local skillCount = mob:getLocalVar('skillCount') + 1
    if skillCount == 3 then
        local offset = (mob:getBattlefield():getArea() - 1) * 10
        for i = 0, 2 do
            local shieldMob = GetMobByID(ID.mob.MEMORY_RECEPTACLE_SHIELD + offset + i)
            if shieldMob and shieldMob:isAlive() then
                shieldMob:setLocalVar('useEmptySeed', 1)
            end
        end

        mob:setLocalVar('skillCount', 0)
    else
        mob:setLocalVar('skillCount', skillCount)
    end

    return xi.mobSkill.EMPTY_SEED
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        if not battlefield then
            return
        end

        for _, mobEntity in pairs(battlefield:getMobs()) do
            if mobEntity:getID() ~= mob:getID() and mobEntity:isAlive() then
                mobEntity:setHP(0)
            end
        end
    end
end

return entity
