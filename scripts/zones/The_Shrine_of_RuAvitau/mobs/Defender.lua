-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Defender
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("petCount", 1)
end

entity.onMobFight = function(mob, target)
    local auraGear = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")

    -- Summons an Aura Gear every 15 seconds.
    -- Defenders can also still spawn the Aura Gears while sleeping, etc.
    -- Maximum number of pets Defender can spawn is 5
    if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not auraGear:isSpawned() and mob:getLocalVar("summoning") == 0 then
        mob:setLocalVar("summoning", 1)
        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)

        mob:timer(5000, function(mobArg)
            if mobArg:isAlive() then
                mobArg:entityAnimationPacket("shsm")
                auraGear:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
                auraGear:spawn()
                if mobArg:getTarget() ~= nil then
                    auraGear:updateEnmity(target)
                end
                mobArg:setLocalVar("petCount", petCount + 1)
                mobArg:setLocalVar("summoning", 0)
                mobArg:SetAutoAttackEnabled(true)
                mobArg:SetMobAbilityEnabled(true)
            end
        end)
    end

    -- make sure pet has a target
    if auraGear:getCurrentAction() == xi.act.ROAMING then
        auraGear:updateEnmity(target)
    end
end

entity.onMobDisengage = function(mob)
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
end

return entity
