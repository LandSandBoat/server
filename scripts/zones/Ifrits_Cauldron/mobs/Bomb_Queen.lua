-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Queen
--  Vid: https://www.youtube.com/watch?v=AVsEbYjSAHM
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 15000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 3370)
    mob:setMod(xi.mod.STUN_MEVA, 50)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:setLocalVar('spawn_time', os.time() + 5) -- five seconds for first pet
end

entity.onMobFight = function(mob, target)
    -- Every 30 seconds spawn a random Prince or Princess. If none remain then summon the Bastard.
    -- Retail confirmed
    if os.time() >= mob:getLocalVar('spawn_time') then
        mob:setLocalVar('spawn_time', os.time() + 30)
        local mobId = mob:getID()
        local canSpawnPet = false
        for id = mobId + 1, mobId + 5 do
            if GetMobByID(id):getCurrentAction() == xi.action.NONE then
                canSpawnPet = true
                break
            end
        end

        if canSpawnPet then
            mob:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
            mob:timer(5000, function(bombQueen)
                if bombQueen:isDead() then
                    return
                end

                bombQueen:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
                local bombQueenId = mob:getID()

                -- Pick a random Prince or Princess
                local petId = 0
                local offset = math.random(1, 4)
                for i = 0, 3 do
                    local id = bombQueenId + 1 + (offset + i) % 4
                    if GetMobByID(id):getCurrentAction() == xi.action.NONE then
                        petId = id
                        break
                    end
                end

                -- If no Princes or Princesses remain then try the Bastard
                if petId == 0 then
                    petId = bombQueenId + 5
                    if GetMobByID(petId):getCurrentAction() ~= xi.action.NONE then
                        return
                    end
                end

                local pet = GetMobByID(petId)
                if not pet then
                    return
                end

                local pos = mob:getPos()
                pet:setSpawn(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2), pos.rot)
                pet:spawn()
                local newtarget = mob:getTarget()
                if newtarget then
                    pet:updateEnmity(newtarget)
                end
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- pets die with queen
    if optParams.isKiller then
        local mobId = mob:getID()
        for i = mobId + 1, mobId + 5 do
            local pet = GetMobByID(i)
            if pet and pet:isAlive() then
                pet:setHP(0)
            end
        end
    end
end

return entity
