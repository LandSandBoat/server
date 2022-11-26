-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local offsets = { 1, 3, 5, 2, 4, 6 }

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 466)
    mob:setMod(xi.mod.ATT, 344)
    mob:setMod(xi.mod.EVA, 450)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.DARK_MEVA, 100)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("spawnTime", os.time() + 45)
end

entity.onMobFight = function(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local fifteenBlock = mob:getBattleTime() / 15

    if twohourTime == 0 then
        twohourTime = math.random(4, 6)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if fifteenBlock > twohourTime and mob:getHPP() <= 85 and mob:canUseAbilities() then
        mob:setLocalVar("skill_tp", mob:getTP())
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(4, 6))
    end

    if os.time() > spawnTime and mob:canUseAbilities() then
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
                        local pos = mob:getPos()
                        pet:setPos(pos.x, pos.y, pos.z)
                        if mob:getTarget() ~= nil then
                            pet:updateEnmity(target)
                        end
                    end
                end)
                break
            end
        end
        local random = math.random(40, 45)
        mob:setLocalVar("spawnTime", os.time() + random)
    end

    -- Vrtra draws in if you attempt to leave the room
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() < 180 and target:getZPos() > -305 and target:getZPos() < -290) and os.time() > drawInWait then
        local rot = target:getRotPos()
        target:setPos(180.79, 7.5, -299.96, rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobDisengage = function(mob, weather)
    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID() + offset)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Don't lose TP from charm 2hr
    if skill:getID() == 710 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENDARK, { power = math.random(45, 90), chance = 10 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VRTRA_VANQUISHER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(259200, 432000)) -- 3 to 5 days
end

return entity
