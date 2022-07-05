-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-----------------------------------
require("scripts/globals/titles")
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("xolotlDead", 0)
end

entity.onMobFight = function(mob,target)
    local timeInterval = mob:getBattleTime() % 6

    -- Spawn skeleton pets
    for i = 1, 2 do
        local child = GetMobByID(mob:getID() + i)
        if child:isSpawned() then
            if target and child:getCurrentAction() == xi.act.ROAMING then -- doing nothing, make share enmity
                child:updateEnmity(target)
            end
        elseif mob:getCurrentAction() ~= 30 and mob:actionQueueEmpty() and timeInterval == (i-1)*3 then -- not spawned, not casting, not using an ability and should summon
            mob:SetMagicCastingEnabled(false)
            mob:entityAnimationPacket("casm")
            mob:timer(1500, function(xolotl)
                xolotl:entityAnimationPacket("shsm")
                xolotl:SetMagicCastingEnabled(true)
                local pos = xolotl:getPos()
                child:setSpawn(pos.x + i, pos.y - 0.5, pos.z - i, pos.rot)
                child:spawn()
            end)
        end
    end
end

entity.onMobRoam = function(mob)
    local mobId = mob:getID()

    for i = 1, 2 do
        local child = GetMobByID(mobId + i)
        if child:isSpawned() and child:getID() == mobId + 1 then
            child:pathTo(mob:getXPos() + 1, mob:getYPos() + 3, mob:getZPos() + 0.15)
        elseif child:isSpawned() and child:getID() == mobId + 2 then
            child:pathTo(mob:getXPos() + 3, mob:getYPos() + 5, mob:getZPos() + 0.15)
        end
    end

    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then -- Despawn Xolotl if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Can be slept with Lullaby once after each Charm, after which he builds resistance.
    if skill:getID() == 533 or skill:getID() == 1329 then
        mob:setMod(xi.mod.SLEEPRESTRAIT, 20)
    end
end

entity.onMagicHit = function(caster, target, spell)
    -- Sets max sleep resist if a light based sleep lands on Xolotl
    if spell:tookEffect() and caster:isPC() and (spell:getID() == 376 or
    spell:getID() == 463 or spell:getID() == 576 or spell:getID() == 584) then
        target:setMod(xi.mod.SLEEPRESTRAIT, 100)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.XOLOTL_XTRAPOLATOR)

    mob:setLocalVar("xolotlDead", 1)
end

entity.onMobDespawn = function(mob)
    -- Xolotl respawn timer only triggers on death, will respawn next game night if not defeated
    local xolotlDead = mob:getLocalVar("xolotlDead")

    if xolotlDead == 1 then
        UpdateNMSpawnPoint(mob:getID())
        local respawn = math.random(75600, 86400) -- 21h to 24h
        mob:setRespawnTime(respawn)
        mob:setLocalVar("xolotlRespawn",(os.time() + respawn))
        DisallowRespawn(ID.mob.XOLOTL, true)
    elseif xolotlDead == 0 then
        DisallowRespawn(ID.mob.XOLOTL, true)
    end
end

return entity
