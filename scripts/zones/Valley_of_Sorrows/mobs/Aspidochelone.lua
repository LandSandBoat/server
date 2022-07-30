-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local intoShell = function(mob)
    mob:setAnimationSub(1)
    mob:SetMobAbilityEnabled(false)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:setMod(xi.mod.REGEN, 200)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
end

local outOfShell = function(mob)
    mob:setTP(3000) -- Immediately TPs coming out of shell
    mob:setAnimationSub(2)
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(false)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
end

entity.onMobSpawn = function(mob)
    if xi.settings.main.LandKingSystem_NQ > 0 or xi.settings.main.LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
        SetDropRate(183, 1525, 150) -- 15% drop rate for adamantoise egg
        mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    end

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:SetMobAbilityEnabled(true)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(false) -- will not cast until it goes into shell
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.DMGMAGIC, -3000)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.CURSERES, 100)

    local changeHP = mob:getHP() - (mob:getHP() * .05)
    mob:setLocalVar("changeHP", changeHP)
    mob:setLocalVar("DamageTaken", 0)
    mob:setAnimationSub(2)

    -- Forced out of shell after taking 2000 damage
    mob:addListener("TAKE_DAMAGE", "ASPID_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        local damageTaken = mobArg:getLocalVar("DamageTaken")
        local waitTime = mobArg:getLocalVar("waitTime")
        damageTaken = damageTaken + amount
        if damageTaken > 2000 then
            mobArg:setLocalVar("DamageTaken", 0)
            if mobArg:getAnimationSub() == 1 and os.time() > waitTime then
                mobArg:setAnimationSub(2)
                changeHP = mobArg:getHP() - (mobArg:getHP() * .05)
                mobArg:setLocalVar("changeHP", changeHP)
                mobArg:setLocalVar("waitTime", os.time() + 2)
                outOfShell(mobArg)
            end
        elseif os.time() > waitTime then
            mob:setLocalVar("DamageTaken", damageTaken)
        end
    end)
end

entity.onMobFight = function(mob, target)
    local changeHP = mob:getLocalVar("changeHP")
    local waitTime = mob:getLocalVar("waitTime")

    if mob:getHP() < changeHP and mob:getAnimationSub() == 2 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:setAnimationSub(1)
        mob:setLocalVar("waitTime", os.time() + 2)
        intoShell(mob)
    elseif mob:getHPP() == 100 and mob:getAnimationSub() == 1 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:setAnimationSub(2)
        changeHP = mob:getHP() - (mob:getHP() * .05)
        mob:setLocalVar("changeHP", changeHP)
        mob:setLocalVar("waitTime", os.time() + 2)
        outOfShell(mob)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
    mob:removeListener("ASPID_TAKE_DAMAGE")
end

entity.onMobDespawn = function(mob)
    -- Set Aspidochelone's Window Open Time
    if xi.settings.main.LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]Aspidochelone", os.time() + wait) -- 3 days
        if xi.settings.main.LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Adamantoise's spawnpoint and respawn time (21-24 hours)
    if xi.settings.main.LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]Aspidochelone", 0)
        DisallowRespawn(ID.mob.ADAMANTOISE, false)
        UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
        GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
    -- Respawn the ???
    if xi.settings.main.LandKingSystem_HQ == 2 or xi.settings.main.LandKingSystem_NQ == 2 then
        GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
