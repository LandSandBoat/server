-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Vrtra summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local offsets = {7, 9, 11, 8, 10, 12}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 100)
    mob:addMod(xi.mod.LULLABYRES, 100)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.SIGHT_ANGLE, 90)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 75)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DMGMAGIC, -50)
    mob:setMod(xi.mod.DEF, 500)
    mob:setMod(xi.mod.MATT, 75)
end

entity.onMobEngaged = function(mob, target)
    mob:resetLocalVars()
end

entity.onMobFight = function(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local fifteenBlock = mob:getBattleTime() / 3

    if twohourTime == 0 then
        twohourTime = math.random(1, 2)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if fifteenBlock > twohourTime and target:getDistance() < 17 then -- Spams Charm in bv2 version every 5s
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(1, 2))
    elseif fifteenBlock > spawnTime + 10 then
        mob:entityAnimationPacket("casm")
        mob:timer(3000, function(mobArg)
            local mobId = mobArg:getID()
            for i, offset in ipairs(offsets) do
                local pet = GetMobByID(mobId + offset)

                if not pet:isSpawned() then
                    mobArg:entityAnimationPacket("shsm")
                    pet:spawn(60)
                    local pos = mobArg:getPos()
                    pet:setPos(pos.x, pos.y, pos.z)
                    pet:updateEnmity(mobArg:getTarget())

                    break
                end
            end
        end)
        mob:setLocalVar("spawnTime", fifteenBlock + 4)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENDARK, {power = math.random(45, 90), chance = 10})
end

entity.onMobWeaponSkill = function(target, mob, skill, action)
    local skillID = skill:getID()
    if skillID == 710 then
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    -- Despawn adds when Vrtra dies
    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID()+offset)
    end
end

return entity
