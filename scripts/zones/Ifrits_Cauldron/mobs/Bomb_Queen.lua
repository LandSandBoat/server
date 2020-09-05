-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Queen
--  Vid: https://www.youtube.com/watch?v=AVsEbYjSAHM
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMod(tpz.mod.STUNRES, 50)
end

function onMobSpawn(mob)
    mob:setLocalVar("petCooldown", os.time() + 5) -- five seconds for first pet
end

function onMobFight(mob, target)
    -- every ~20 seconds after first pet, a new pet will spawn around queen's position.
    -- 49.5% (198/400) chance for Prince/Princess. 1% (4/400) chance for Bomb Bastard.
    if os.time() > mob:getLocalVar("petCooldown") then
        local petId = mob:getID() + 1 + math.floor(math.random(0, 399) / 99)
        local pet = GetMobByID(petId)

        if pet and not pet:isSpawned() then
            local pos = mob:getPos()
            pet:setSpawn(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2), pos.rot)
            pet:spawn()
            pet:updateEnmity(target)

            mob:setLocalVar("petCooldown", os.time() + 20)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    -- pets die with queen
    if isKiller then
        local mobId = mob:getID()
        for i = mobId + 1, mobId + 5 do
            local pet = GetMobByID(i)
            if pet:isAlive() then
                pet:setHP(0)
            end
        end
    end
end
