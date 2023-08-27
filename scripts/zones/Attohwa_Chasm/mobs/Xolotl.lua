-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/follow")
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("xolotlDead", 0)
end

entity.onMobFight = function(mob, target)
    local timeInterval = mob:getBattleTime() % 6

    -- Spawn skeleton pets
    for i = 1, 2 do
        local child = GetMobByID(mob:getID() + i)
        if child:isSpawned() then
            if target and child:getCurrentAction() == xi.act.ROAMING then -- doing nothing, make share enmity
                child:updateEnmity(target)
            end
        elseif -- not spawned, not casting, not using an ability and should summon
                mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
                mob:actionQueueEmpty() and
                timeInterval == (i - 1) * 3
        then
            mob:setMagicCastingEnabled(false)
            mob:setAutoAttackEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:entityAnimationPacket("casm")
            mob:timer(1500, function(xolotl)
                xolotl:entityAnimationPacket("shsm")
                xolotl:setMagicCastingEnabled(true)
                mob:setAutoAttackEnabled(true)
                mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                local pos = xolotl:getPos()
                child:setSpawn(pos.x + i, pos.y - 0.5, pos.z - i, pos.rot)
                child:spawn()
                xi.follow.follow(child, mob)
            end)
        end
    end

    -- Sets max sleep resist if a sleep lands on Xolotl
    if
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        target:setMod(xi.mod.SLEEPRES, 100)
    end
end

entity.onMobRoam = function(mob)
    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then -- Despawn Xolotl if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Can be slept with Lullaby once after each Charm, after which he builds resistance.
    if skill:getID() == 533 or skill:getID() == 1329 then
        mob:setMod(xi.mod.SLEEPRES, 20)
    end
end

entity.onMagicHit = function(caster, target, spell)
    -- Sets max sleep resist if a light based sleep lands on Xolotl
    if
        spell:tookEffect() and
        caster:isPC() and
        (spell:getID() == 376 or
        spell:getID() == 463 or
        spell:getID() == 576 or
        spell:getID() == 584)
    then
        target:setMod(xi.mod.SLEEPRES, 100)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.XOLOTL_XTRAPOLATOR)

    SetServerVariable("xolotlDead", 1)
end

entity.onMobDespawn = function(mob)
    -- Xolotl respawn timer only triggers on death, will respawn next game night if not defeated
    local xolotlDead = GetServerVariable("xolotlDead")
    local cooldown = math.random(75600, 86400) -- 21h to 24h

    if xolotlDead == 1 then
        xi.mob.nmTODPersist(mob, cooldown)
        DisallowRespawn(ID.mob.XOLOTL, true)
    elseif xolotlDead == 0 then
        DisallowRespawn(ID.mob.XOLOTL, true)
    end
end

return entity
