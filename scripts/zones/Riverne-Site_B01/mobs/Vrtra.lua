-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Vrtra summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/follow")
-----------------------------------
local entity = {}

local offsets = { 7, 9, 11, 8, 10, 12 }

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 75)
    mob:setMod(xi.mod.DEF, 466)
    mob:setMod(xi.mod.ATT, 344)
    mob:setMod(xi.mod.EVA, 450)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.DARK_MEVA, 100)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.MATT, 75)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:resetLocalVars()
    -- if engaged then send pets at target
    for i, offset in ipairs(offsets) do
        local pet = GetMobByID(mob:getID() + offset)
        if pet:isAlive() then
            pet:updateEnmity(mob:getTarget())
        end
    end
end

entity.onMobFight = function(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local threeSecTick = mob:getBattleTime() / 3

    if twohourTime == 0 then
        twohourTime = math.random(1, 2)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if
        threeSecTick > twohourTime and
        mob:checkDistance(target) < 17 and
        mob:canUseAbilities()
    then -- Spams Charm in bv2 version every 5s
        mob:setLocalVar("skill_tp", mob:getTP())
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", threeSecTick + math.random(1, 2))
    elseif threeSecTick > spawnTime + 10 then
        local mobId = mob:getID()

        for _, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if not pet:isSpawned() then
                mob:entityAnimationPacket("casm")
                mob:setAutoAttackEnabled(false)
                mob:setMagicCastingEnabled(false)
                mob:setMobAbilityEnabled(false)

                mob:timer(3000, function(mobArg)
                    if mobArg:isAlive() then
                        mobArg:entityAnimationPacket("shsm")
                        mobArg:setAutoAttackEnabled(true)
                        mobArg:setMagicCastingEnabled(true)
                        mobArg:setMobAbilityEnabled(true)
                        pet:spawn()
                        local pos = mobArg:getPos()
                        pet:setPos(pos.x, pos.y, pos.z)
                        local options = { followDistance = 0.0 }
                        xi.follow.follow(pet, mobArg, options)
                        if mobArg:getTarget() ~= nil then
                            pet:updateEnmity(target)
                        end
                    end
                end)

                break
            end
        end

        mob:setLocalVar("spawnTime", threeSecTick + 4)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENDARK, { power = math.random(45, 90), chance = 10 })
end

entity.onMobWeaponSkill = function(target, mob, skill, action)
    local skillID = skill:getID()
    if skillID == 710 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar("deathTrigger") == 0 then
        -- if vrtra dies then kill all pets
        local mobId = mob:getID()
        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)
            if pet:isAlive() then
                pet:setHP(0)
            end
        end

        mob:setLocalVar("deathTrigger", 1)
    end
end

return entity
